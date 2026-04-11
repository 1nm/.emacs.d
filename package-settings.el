;; nyan mode
(nyan-mode 1)
(nyan-start-animation)

;; anzu mode, remap query replace (regexp) to anzu
(require 'anzu)
(global-anzu-mode +1)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "yellow" :weight 'bold)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => "))
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(define-key global-map (kbd "C-c C-r") 'query-replace-regexp)

;; recentf mode
(recentf-mode 1)

;; display line numbers mode
(global-display-line-numbers-mode 1)
;; display column numbers
(setq column-number-mode t)
;; (setq linum-format "%4d ")

;; helm mode
(helm-mode 1)

;; helm key rebinding
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key global-map (kbd "C-x C-f") 'helm-for-files)
(define-key global-map (kbd "C-x C-g") 'helm-grep-do-git-grep)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-c C-i") 'helm-imenu)

(setq helm-for-files-preferred-list
      '(helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir))

;; whitespace-mode hooks
;; (add-hook 'prog-mode-hook 'whitespace-mode)
;; (setq whitespace-line-column 500)

;; scroll shortcuts
(define-key global-map (kbd "M-n") 'scroll-down-line)
(define-key global-map (kbd "M-p") 'scroll-up-line)

;; markdown tables
(require 'org-table)

(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))
    ))

(add-hook 'markdown-mode-hook 'orgtbl-mode)
(add-hook 'markdown-mode-hook
          (lambda()
            (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)))

;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; ── Markdown live preview (right-side split, eww) ────────────────────────────
;; Pin any eww buffer to a fixed right-side window
(add-to-list 'display-buffer-alist
             '((lambda (buf _) (with-current-buffer buf (derived-mode-p 'eww-mode)))
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 0.45)))

(with-eval-after-load 'markdown-mode
  ;; Remove the exported HTML file after preview closes
  (setq markdown-live-preview-delete-export 'delete-on-export)
  ;; C-c p to toggle live preview
  (define-key markdown-mode-map (kbd "C-c p") 'markdown-live-preview-mode))

;; start server for emacsclients
;; (server-start)

;; ── Notes (iCloud Markdown) ──────────────────────────────────────────────────
(defvar my-notes-dir
  (expand-file-name "~/Library/Mobile Documents/com~apple~CloudDocs/Notes/")
  "Directory for Markdown notes synced via iCloud.")

(unless (file-directory-p my-notes-dir)
  (make-directory my-notes-dir t))

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

(defun my-open-latest-note ()
  "Open the most recently modified Markdown file in the notes directory."
  (interactive)
  (when (file-directory-p my-notes-dir)
    (let* ((files (directory-files-recursively my-notes-dir "\\.md\\'"))
           (sorted (sort files
                         (lambda (a b)
                           (time-less-p (nth 5 (file-attributes b))
                                        (nth 5 (file-attributes a))))))
           (latest (car sorted)))
      (if latest
          (find-file latest)
        (message "No notes found in %s" my-notes-dir)))))

(defun my-new-note (category title)
  "Create a new date-prefixed Markdown note under CATEGORY in the notes directory."
  (interactive
   (list (completing-read "Category: " '("journal" "projects" "topics") nil nil)
         (read-string "Title: ")))
  (let* ((date-str (format-time-string "%Y-%m-%d"))
         (slug (replace-regexp-in-string "[[:space:]]+" "-"
                (replace-regexp-in-string "[^[:alnum:][:space:]-]" "" title)))
         (dir (expand-file-name category my-notes-dir))
         (filename (expand-file-name (concat date-str "-" slug ".md") dir)))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (find-file filename)
    (when (= (buffer-size) 0)
      (insert (format "# %s\n\n" title)))))

(define-key global-map (kbd "C-c n n") 'my-new-note)
(define-key global-map (kbd "C-c n l") 'my-open-latest-note)
(define-key global-map (kbd "C-c n i")
  (lambda () (interactive)
    (find-file (expand-file-name "inbox.md" my-notes-dir))))

;; Open the latest note on startup
(my-open-latest-note)
