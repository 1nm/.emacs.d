;; nyan mode
(nyan-mode 1)
(nyan-start-animation)

;; auto complete mode
(global-auto-complete-mode 1)
(setq ac-modes '(java-mode))
(setq ac-modes '(python-mode))

;; highlight symbol mode hooks
(add-hook 'groovy-mode-hook 'highlight-symbol-mode)
(add-hook 'java-mode-hook 'highlight-symbol-mode)
(add-hook 'python-mode-hook 'highlight-symbol-mode)
(add-hook 'scala-mode-hook 'highlight-symbol-mode)

;; anzu mode, remap query replace (regexp) to anzu
(global-anzu-mode 1)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)
(define-key global-map (kbd "C-c C-r") 'query-replace-regexp)

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
(define-key global-map (kbd "C-x C-g") 'helm-grep-do-git-grep)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-c C-i") 'helm-imenu)

(setq helm-for-files-preferred-list
      '(helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir))

;; helm-projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)

;; enable exec-path-from-shell
;; (when (memq window-system '(mac ns))
(exec-path-from-shell-initialize)

;; whitespace-mode hooks
;;(add-hook 'python-mode-hook 'whitespace-mode)
;;(add-hook 'java-mode-hook 'whitespace-mode)
;;(add-hook 'c-mode-hook 'whitespace-mode)
;;(add-hook 'scala-mode-hook 'whitespace-mode)
;;(add-hook 'dockerfile-mode-hook 'whitespace-mode)
;;(add-hook 'yaml-mode-hook 'whitespace-mode)
;;(add-hook 'gradle-mode-hook 'whitespace-mode)
;;(add-hook 'markdown-mode-hook 'whitespace-mode)
(setq whitespace-line-column 250)

;; enable flycheck-mode for python-mode
;; requires flake8 and pylint
(add-hook 'python-mode-hook 'flycheck-mode)
(setq flycheck-flake8-maximum-line-length 250)

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

;; start server for emacsclients
(server-start)
