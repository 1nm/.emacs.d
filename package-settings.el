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
(define-key global-map (kbd "M-x") 'helm-M-x)

;; helm-projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)

;; enable whitespace-mode for python-mode
;; (add-hook 'python-mode-hook 'whitespace-mode)
;; (whitespace-line-column 100)

;; enable flycheck-mode for python-mode
;; requires flake8 and pylint
(add-hook 'python-mode-hook 'flycheck-mode)

;; start server for emacsclients
;; (server-start)
