(load "~/.emacs.d/load-packages.el")
(add-hook 'after-init-hook '(lambda ()
  (load "~/.emacs.d/package-settings.el")
))

(setq default-directory "~/")
(setq-default auto-save-default t)

;; set default coding system
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; this may be useful if you use emacsclient
;; remap C-x C-c to delete frame without killing emacs
;; to kill emacs, use M-x kill-emacs
;; (global-set-key "\C-x\C-c" 'delete-frame)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-timeout 10)
 '(custom-enabled-themes (quote (tango-dark)))
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120)))))
