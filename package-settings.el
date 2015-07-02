;; nyan mode
(if (display-graphic-p)
    (progn
      (nyan-mode 1)
      (nyan-start-animation)))

;; auto complete mode
(global-auto-complete-mode 1)
(setq ac-modes '(python-mode))

;; auto highlight symbol mode
(global-auto-highlight-symbol-mode 1)

;; anzu mode, remap query replace (regexp) to anzu
(global-anzu-mode 1)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)

;; recentf mode
(recentf-mode 1)

;; linum mode
(global-linum-mode 1)
(setq linum-format "%4d ")

;; helm mode
(helm-mode 1)

;; helm key rebinding
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key global-map (kbd "C-x C-f") 'helm-for-files)
(define-key global-map (kbd "C-x C-g") 'helm-find-files)
(define-key global-map (kbd "M-x") 'helm-M-x)

(setq helm-for-files-preferred-list
      '(helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir))

;; helm-projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)

;; enable exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; enable whitespace-mode for python-mode
;; (add-hook 'python-mode-hook 'whitespace-mode)
(setq whitespace-line-column 250)

;; enable flycheck-mode for python-mode
;; requires flake8 and pylint
(add-hook 'python-mode-hook 'flycheck-mode)
(setq flycheck-flake8-maximum-line-length 250)

;; magit

(setq magit-last-seen-setup-instructions "1.4.0")

;; start server for emacsclients
;; (server-start)
