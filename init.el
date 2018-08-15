
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/load-packages.el")
(add-hook 'after-init-hook '(lambda ()
  (load "~/.emacs.d/package-settings.el")
))

(setq default-directory "~/")
(setq-default auto-save-default t)

;; set default coding system
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(auto-save-timeout 10)
 '(custom-enabled-themes (quote (tango-dark)))
 '(default-frame-alist (quote ((width . 200) (height . 80))))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(flycheck-flake8-maximum-line-length 120)
 '(flycheck-python-flake8-executable "/usr/local/bin/flake8")
 '(flycheck-python-pycompile-executable "/usr/local/bin/python3")
 '(global-eldoc-mode nil)
 '(global-hl-line-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(markdown-command "pandoc -c ~/.pandoc/github.css")
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(org-log-done (quote time))
 '(org-todo-keyword-faces
   (quote
    (("WAITING" . "Magenta")
     ("WORKING" . "Cyan")
     ("CANCELLED" . "Gray")
     ("SOMEDAY" . "SteelBlue"))))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WORKING(w)" "WAITING(a)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)"))))
 '(package-selected-packages
   (quote
    (helm-rg meghanada go-mode groovy-mode scala-mode yaml-mode markdown-mode dockerfile-mode helm-ispell yasnippet python-mode nyan-mode magit json-mode helm-pydoc helm-projectile helm-gtags helm flycheck exec-path-from-shell auto-complete anzu)))
 '(python-mode-hook (quote (whitespace-mode)))
 '(python-shell-interpreter "python3")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(whitespace-style
   (quote
    (face tabs spaces trailing lines space-before-tab newline empty space-after-tab space-mark tab-mark newline-mark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Source Code Pro")))))
