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
  '(diff-hl nyan-mode rainbow-delimiters)
  "Packages used by this configuration.  Missing ones are installed at startup.
Everything a built-in covers is left to the built-in: completion is
`fido-vertical-mode', git is `vc' (C-x v), Markdown/JSON/YAML/Python/shell/TOML
are tree-sitter modes, LSP is `eglot', in-buffer completion is
`completion-preview-mode'.  These three have no built-in counterpart at all.")

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

;; package.el regenerates package-quickstart.el whenever a package is installed
;; or removed -- but only once the file exists.  Create it the first time so
;; startup loads one precompiled autoloads file instead of one per package.
(unless (file-exists-p (expand-file-name "package-quickstart.el" user-emacs-directory))
  (require 'package)
  (package-quickstart-refresh))

;;; Custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

;;; General settings
(setq default-directory "~/")
(setq-default auto-save-default t)

;; Default coding system
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; Line numbers where they are useful (not in eww, *Help*, dired, ...).
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))
(setq column-number-mode t)

;; Spell checker: pick whichever is actually installed instead of failing on
;; a hard-coded one.  Install with `brew install hunspell'.
(setq ispell-program-name
      (or (executable-find "hunspell") (executable-find "aspell") "ispell")
      ispell-really-hunspell (and (executable-find "hunspell") t))

;;; Built-in quality-of-life modes
(savehist-mode 1)                  ; persist minibuffer history (fido sorts by it)
(save-place-mode 1)                ; reopen files at the last cursor position
(recentf-mode 1)                   ; recent file list, reachable with C-x C-r
(global-auto-revert-mode 1)        ; reload files changed on disk
(delete-selection-mode 1)          ; typing replaces the active region
(electric-pair-mode 1)             ; auto-close brackets and quotes
(repeat-mode 1)                    ; C-x o o o ... instead of C-x o C-x o
(global-so-long-mode 1)            ; stay responsive in files with huge lines
(which-key-mode 1)                 ; show the keys following a prefix
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1)) ; smooth trackpad scrolling

(context-menu-mode 1)              ; right click acts on what is under the pointer

(setq isearch-lazy-count t         ; "3/17" in the isearch prompt
      lazy-count-prefix-format "%s/%s "
      recentf-max-saved-items 200
      auto-revert-verbose nil
      use-short-answers t          ; y/n instead of yes/no
      sentence-end-double-space nil
      switch-to-buffer-obey-display-actions t
      ;; `C-x t' is the built-in tab prefix: C-x t 2 new, C-x t 0 close,
      ;; C-x t o next.  tab-bar-mode turns itself on with the first extra tab.
      tab-bar-show 1               ; hide the bar until there are 2+ tabs
      tab-bar-new-tab-choice "*scratch*"
      tab-bar-tab-hints t)         ; number the tabs, for C-x t <n>

;; URLs and email addresses in comments become clickable.
(add-hook 'prog-mode-hook #'goto-address-prog-mode)

;; Scroll shortcuts
(define-key global-map (kbd "M-n") 'scroll-down-line)
(define-key global-map (kbd "M-p") 'scroll-up-line)
(define-key global-map (kbd "C-c C-r") 'query-replace-regexp)

;; Editing and buffer bindings the defaults leave on the floor.
(define-key global-map (kbd "C-x C-M-d") 'duplicate-dwim)  ; copy line or region
(define-key global-map (kbd "M-/") 'hippie-expand)         ; wider than dabbrev
(define-key global-map (kbd "C-x C-b") 'ibuffer)           ; not list-buffers
(define-key global-map (kbd "C-c C-i") 'imenu)             ; kept from the helm days
(define-key global-map (kbd "C-x C-r") 'recentf-open)      ; C-x C-f for recent files

;;; Completion (built in)
;; `fido-vertical-mode' is icomplete's vertical, ido-flavoured UI: candidates
;; listed under the prompt, RET takes the highlighted one.  Inside the
;; minibuffer it forces the `flex' style (icomplete.el:523), so "dfci" finds
;; display-fill-column-indicator-mode.
(fido-vertical-mode 1)

(setq ;; icomplete renders `affixation-function' metadata (icomplete.el:864),
      ;; and this is what makes commands publish it -- so M-x shows each
      ;; command's key binding and the first line of its doc string.
      completions-detailed t
      icomplete-prospects-height 15
      icomplete-compute-delay 0
      icomplete-max-delay-chars 0
      ;; Styles for completion *outside* the minibuffer -- completion-at-point
      ;; and completion-preview -- which fido's local settings never reach.
      completion-styles '(flex basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;;; Editing and navigation

;; Colour parens by nesting depth.  No built-in equivalent; `show-paren-mode'
;; (on, via custom.el) only highlights the matching one, and the setting below
;; makes it show the opening line when that paren is scrolled off screen.
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq show-paren-context-when-offscreen 'overlay)

;; The cat. Lives in the mode line, so it is loaded right away.
(use-package nyan-mode
  :config
  (nyan-mode 1)
  (nyan-start-animation))

;;; Git
;; The built-in `vc' handles this; `C-x v' is its prefix.  Beyond the bindings
;; below it also has full stash support -- `vc-git-stash', -apply, -pop,
;; -delete, -show, -snapshot -- reachable from `z' in a vc-dir buffer.
(define-key global-map (kbd "C-x g") 'vc-dir)
(define-key global-map (kbd "C-x C-g") 'vc-git-grep)

;; Added/changed/removed lines in the fringe, per buffer and in dired.
;; Nothing built in draws these.
(use-package diff-hl
  :hook ((prog-mode  . diff-hl-mode)
         (text-mode  . diff-hl-mode)
         (conf-mode  . diff-hl-mode)
         (dired-mode . diff-hl-dired-mode))
  :config
  (diff-hl-flydiff-mode 1))         ; update without having to save first

;;; Code intelligence (built in -- no lsp-mode/company needed)

;; Inline greyed-out completion suggestion as you type.  Its default cycling
;; keys are M-n/M-p, which this config uses for scrolling, so move them.
(add-hook 'prog-mode-hook #'completion-preview-mode)
(with-eval-after-load 'completion-preview
  (define-key completion-preview-active-mode-map (kbd "M-n") nil)
  (define-key completion-preview-active-mode-map (kbd "M-p") nil)
  (define-key completion-preview-active-mode-map (kbd "C-M-n") #'completion-preview-next-candidate)
  (define-key completion-preview-active-mode-map (kbd "C-M-p") #'completion-preview-prev-candidate))

;; eglot is the built-in LSP client.  Start it per project with `M-x eglot';
;; it is deliberately not auto-started, since that errors out when no language
;; server is installed.
(use-package eglot
  :defer t
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format)
              ("C-c l d" . eldoc-doc-buffer)))

;; flymake is the built-in checker.  eglot switches it on for LSP buffers;
;; elsewhere it is `M-x flymake-mode'.  Not enabled globally on purpose: on
;; plain elisp its backend reports every free variable in a config file.
(with-eval-after-load 'flymake
  (keymap-set flymake-mode-map "C-c ! l" #'flymake-show-buffer-diagnostics)
  (keymap-set flymake-mode-map "C-c ! n" #'flymake-goto-next-error)
  (keymap-set flymake-mode-map "C-c ! p" #'flymake-goto-prev-error))

;;; Tree-sitter
;; Grammars are compiled into ~/.emacs.d/tree-sitter by
;; `my/install-treesit-grammars' (needs git and a C compiler).  A mode is only
;; remapped once its grammar is actually present, so a fresh clone still opens
;; these files, just without tree-sitter.
(setq treesit-language-source-alist
      '((bash   "https://github.com/tree-sitter/tree-sitter-bash")
        (json   "https://github.com/tree-sitter/tree-sitter-json" "v0.24.8")
        (markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
                  nil "tree-sitter-markdown/src")
        (markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
                         nil "tree-sitter-markdown-inline/src")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml   "https://github.com/tree-sitter/tree-sitter-toml")
        (yaml   "https://github.com/tree-sitter-grammars/tree-sitter-yaml" "v0.7.0")))

(defun my/install-treesit-grammars ()
  "Compile every grammar in `treesit-language-source-alist' that is missing."
  (interactive)
  (require 'treesit)
  (dolist (source treesit-language-source-alist)
    (let ((lang (car source)))
      (if (treesit-ready-p lang t)
          (message "tree-sitter: %s already installed" lang)
        (treesit-install-language-grammar lang)))))

(defun my/treesit-grammar-p (lang)
  "Non-nil if a compiled tree-sitter grammar for LANG is on disk.
`treesit-ready-p' would answer this properly, but it lives in treesit.el,
and loading that at startup costs ~22ms just to look for these files.
`treesit-available-p' is a C primitive, so it is free."
  (and (fboundp 'treesit-available-p)
       (treesit-available-p)
       (seq-some (lambda (ext)
                   (file-exists-p
                    (expand-file-name (format "tree-sitter/libtree-sitter-%s.%s" lang ext)
                                      user-emacs-directory)))
                 '("dylib" "so" "dll"))))

;; Remapped eagerly: `major-mode-remap-alist' is consulted by `set-auto-mode'
;; the moment a file is opened, so deferring this would simply never apply.
(dolist (pair '((json   . (js-json-mode    . json-ts-mode))
                (python . (python-mode     . python-ts-mode))
                (bash   . (sh-mode         . bash-ts-mode))
                (toml   . (conf-toml-mode  . toml-ts-mode))))
  (when (my/treesit-grammar-p (car pair))
    (add-to-list 'major-mode-remap-alist (cdr pair))))

;; YAML has no built-in non-tree-sitter mode, so it needs an auto-mode entry.
(add-to-list 'auto-mode-alist
             (cons "\\.ya?ml\\'"
                   (if (my/treesit-grammar-p 'yaml) #'yaml-ts-mode #'conf-mode)))

;; Show whitespace in Python, where indentation is syntax.
(add-hook 'python-base-mode-hook #'whitespace-mode)

;;; Markdown
;; Emacs 31's built-in `markdown-ts-mode' replaces the markdown-mode package.
;; It brings a real table editor (align, insert/move/delete rows and columns,
;; CSV/TSV import and export, auto-align while navigating cells), inline
;; images, markup hiding, checkbox toggling, heading promote/demote and subtree
;; moves, and fontification of fenced code blocks in their own language's mode.
;; That table editor is why the old orgtbl-mode workaround is gone, along with
;; the after-save hook that rewrote orgtbl's `-+-' separators into `-|-'.
;;
;; It carries no autoload cookies, so declare them here; markdown-ts-mode is
;; then loaded on the first .md file, not at startup.  `markdown-ts-mode-maybe'
;; falls back to `text-mode' when the grammars are not compiled yet.
(autoload 'markdown-ts-mode "markdown-ts-mode" nil t)
(autoload 'markdown-ts-mode-maybe "markdown-ts-mode" nil t)
(add-to-list 'auto-mode-alist
             '("\\.\\(?:md\\|markdown\\|mkd\\|mdown\\)\\'" . markdown-ts-mode-maybe))

;; Indent wrapped list items and block quotes under their own text.
(add-hook 'markdown-ts-mode-hook #'visual-wrap-prefix-mode)

(defun my/markdown-preview ()
  "Render this Markdown buffer with pandoc and show it in an eww side window.
`markdown-ts-mode' has no preview of its own, and markdown-mode's used a
hard-coded command that failed outright when pandoc was missing."
  (interactive)
  (unless (executable-find "pandoc")
    (user-error "Markdown preview needs pandoc: brew install pandoc"))
  (let ((html (make-temp-file "emacs-md-preview-" nil ".html"))
        (source (current-buffer)))
    (with-temp-buffer
      (let ((out (current-buffer)))
        (with-current-buffer source
          (call-process-region (point-min) (point-max) "pandoc" nil out nil
                               "--from=gfm" "--to=html5" "--standalone"
                               "--metadata" (format "title=%s" (buffer-name)))))
      (write-region (point-min) (point-max) html nil 'silent))
    (eww-open-file html)))

(with-eval-after-load 'markdown-ts-mode
  ;; markdown-ts-mode-map takes C-c C-r for `markdown-ts-renumber-list', which
  ;; would shadow the global query-replace-regexp binding in Markdown buffers.
  (keymap-set markdown-ts-mode-map "C-c p" #'my/markdown-preview)
  (keymap-set markdown-ts-mode-map "C-c C-r" #'query-replace-regexp)
  (keymap-set markdown-ts-mode-map "C-c C-x C-r" #'markdown-ts-renumber-list))

;; Pin eww buffers (markdown preview) to a right-side window.
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

(defun my/search-notes (regexp)
  "Grep the notes directory for REGEXP."
  (interactive (list (read-string "Search notes for: ")))
  (rgrep regexp "*.md" my/notes-dir))

(define-key global-map (kbd "C-c n n") #'my/new-note)
(define-key global-map (kbd "C-c n l") #'my/open-latest-note)
(define-key global-map (kbd "C-c n i") #'my/open-inbox-note)
(define-key global-map (kbd "C-c n s") #'my/search-notes)

;; Start in *scratch* -- a real note buffer on startup means every stray edit
;; needs saving before quitting. Reach for notes explicitly via `C-c n'.

;;; Server
;; The README documents using `emacsclient' as $EDITOR, which needs this.
;; Started from `emacs-startup-hook' so it does not delay the first frame.
(add-hook 'emacs-startup-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

;;; init.el ends here
