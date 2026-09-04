;;; init.el --- Personal Emacs configuration  -*- lexical-binding: t -*-

;; Startup-only settings (GC, frame, package activation) live in early-init.el.
;; Variables and faces saved by `M-x customize' live in custom.el.
;; Packages are declared with the built-in `use-package' and loaded lazily.

;;; Package system
;; Installed packages were already activated from package-quickstart.el (see
;; early-init.el), so package.el itself is not loaded here: it costs ~100ms
;; and is only needed to install something.  `use-package' is built in and
;; autoloads itself on first use.
(defvar my/packages
  '(anzu helm json-mode markdown-mode nyan-mode rainbow-delimiters yaml-mode)
  "Packages used by this configuration.  Missing ones are installed at startup.
helm-ag is not listed: it was removed from MELPA, so it cannot be installed
automatically.  An existing copy in elpa/ keeps working (M-x helm-do-ag), and
helm's own `helm-do-grep-ag' provides the same ag/rg search.")

(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

(let ((missing (seq-remove (lambda (p) (memq p (bound-and-true-p package-activated-list)))
                           my/packages)))
  (when missing
    (require 'package)
    (package-refresh-contents)
    (dolist (p missing)
      (condition-case err
          (package-install p)
        (error (display-warning 'init (format "Could not install %s: %s"
                                              p (error-message-string err))))))))

;;; Custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

;;; General settings
(setq default-directory "~/")
(setq-default auto-save-default t)

;; Default coding system
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; Line and column numbers
(global-display-line-numbers-mode 1)
(setq column-number-mode t)

;; Recent files (used by helm-for-files)
(recentf-mode 1)

;; Scroll shortcuts
(define-key global-map (kbd "M-n") 'scroll-down-line)
(define-key global-map (kbd "M-p") 'scroll-up-line)
(define-key global-map (kbd "C-c C-r") 'query-replace-regexp)

;;; Packages

;; nyan-mode lives in the mode line, so it is loaded right away.
(use-package nyan-mode
  :config
  (nyan-mode 1)
  (nyan-start-animation))

;; anzu: loaded when a query-replace key is pressed, or after 1s idle.
(use-package anzu
  :defer 1
  :bind (([remap query-replace] . anzu-query-replace)
         ([remap query-replace-regexp] . anzu-query-replace-regexp))
  :custom
  (anzu-mode-lighter "")
  (anzu-deactivate-region t)
  (anzu-search-threshold 1000)
  (anzu-replace-threshold 50)
  (anzu-replace-to-string-separator " => ")
  :config
  (global-anzu-mode +1)
  (set-face-attribute 'anzu-mode-line nil :foreground "yellow" :weight 'bold))

;; helm: the commands below are autoloaded, so helm (and tramp, which
;; helm-files pulls in) is only loaded on first use, or after 1s idle.
(use-package helm
  :defer 1
  :bind (("M-x"     . helm-M-x)
         ("C-x C-f" . helm-for-files)
         ("C-x C-g" . helm-grep-do-git-grep)
         ("C-c C-i" . helm-imenu))
  :custom
  (helm-for-files-preferred-list
   '(helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir))
  :config
  (helm-mode 1)
  ;; These keymaps are defined in helm-files, not helm.
  (with-eval-after-load 'helm-files
    (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
    (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)))

;; markdown-mode with org tables.  Emacs does not autoload `orgtbl-mode'
;; itself, so declare it here; org-table is then only loaded when a markdown
;; file is opened (instead of `(require 'org-table)' at startup).
(autoload 'orgtbl-mode "org-table" nil t)

(defun my/markdown-cleanup-org-tables ()
  "Turn orgtbl's `-+-' separators into markdown's `-|-'."
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t)
      (replace-match "-|-"))))

(defun my/markdown-cleanup-org-tables-on-save ()
  (add-hook 'after-save-hook #'my/markdown-cleanup-org-tables nil 'local))

(use-package markdown-mode
  :hook ((markdown-mode . orgtbl-mode)
         (markdown-mode . my/markdown-cleanup-org-tables-on-save))
  ;; C-c p toggles a live preview in eww (see the eww side window below).
  :bind (:map markdown-mode-map ("C-c p" . markdown-live-preview-mode))
  :custom
  ;; Remove the exported HTML file after the preview closes.
  (markdown-live-preview-delete-export 'delete-on-export))

;; Pin eww buffers (markdown live preview) to a right-side window.
(add-to-list 'display-buffer-alist
             '((derived-mode . eww-mode)
               display-buffer-in-side-window
               (side . right)
               (window-width . 0.45)))

;;; Notes (Markdown files synced via iCloud)
(defvar my/notes-dir
  (expand-file-name "~/Library/Mobile Documents/com~apple~CloudDocs/Notes/")
  "Directory for Markdown notes synced via iCloud.")

(defun my/latest-note ()
  "Return the most recently modified Markdown file in `my/notes-dir', or nil."
  (when (file-directory-p my/notes-dir)
    (car (sort (directory-files-recursively my/notes-dir "\\.md\\'")
               (lambda (a b)
                 (time-less-p (file-attribute-modification-time (file-attributes b))
                              (file-attribute-modification-time (file-attributes a))))))))

(defun my/open-latest-note ()
  "Open the most recently modified Markdown note."
  (interactive)
  (let ((latest (my/latest-note)))
    (if latest
        (find-file latest)
      (message "No notes found in %s" my/notes-dir))))

(defun my/open-inbox-note ()
  "Open inbox.md in the notes directory for quick capture."
  (interactive)
  (unless (file-directory-p my/notes-dir)
    (make-directory my/notes-dir t))
  (find-file (expand-file-name "inbox.md" my/notes-dir)))

(defun my/new-note (category title)
  "Create a new date-prefixed Markdown note titled TITLE under CATEGORY."
  (interactive
   (list (completing-read "Category: " '("journal" "projects" "topics") nil nil)
         (read-string "Title: ")))
  (let* ((date-str (format-time-string "%Y-%m-%d"))
         (slug (replace-regexp-in-string
                "[[:space:]]+" "-"
                (replace-regexp-in-string "[^[:alnum:][:space:]-]" "" title)))
         (dir (expand-file-name category my/notes-dir))
         (filename (expand-file-name (concat date-str "-" slug ".md") dir)))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (find-file filename)
    (when (= (buffer-size) 0)
      (insert (format "# %s\n\n" title)))))

(define-key global-map (kbd "C-c n n") #'my/new-note)
(define-key global-map (kbd "C-c n l") #'my/open-latest-note)
(define-key global-map (kbd "C-c n i") #'my/open-inbox-note)

;; Show the latest note instead of *scratch* when Emacs starts without a file.
;; `initial-buffer-choice' runs after init (so it is off the startup path) and
;; also applies to frames created by `emacsclient -c' with no file argument.
(setq initial-buffer-choice
      (lambda ()
        (or (when-let* ((latest (my/latest-note)))
              (find-file-noselect latest))
            (get-buffer-create "*scratch*"))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package json-mode
  :defer t)

(use-package yaml-mode
  :defer t)

;; start server for emacsclients
;; (server-start)

;;; init.el ends here
