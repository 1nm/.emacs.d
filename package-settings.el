;; nyan mode
(nyan-mode 1)
(nyan-start-animation)

;; auto complete mode
(global-auto-complete-mode 1)
(setq ac-modes '(java-mode))
(setq ac-modes '(python-mode))

;; highlight symbol mode hooks
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

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

;; helm-projectile
;; (projectile-global-mode)
;; (setq projectile-completion-system 'helm)
;; (helm-projectile-on)
;; (setq projectile-indexing-method 'alien)

;; enable exec-path-from-shell
;; (when (memq window-system '(mac ns))
(exec-path-from-shell-initialize)

;; whitespace-mode hooks
(add-hook 'prog-mode-hook 'whitespace-mode)
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

;; rainbow-delimiters
(require 'rainbow-delimiters)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; start server for emacsclients
(server-start)

