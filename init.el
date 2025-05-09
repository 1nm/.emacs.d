;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(load "~/.emacs.d/load-packages.el")
(add-hook 'after-init-hook '(lambda () (load "~/.emacs.d/package-settings.el") ))

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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff"
    "#eeeeec"])
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(auto-save-timeout 10)
 '(custom-enabled-themes '(tango-dark))
 '(default-frame-alist '((width . 200) (height . 80)))
 '(ediff-split-window-function 'split-window-horizontally)
 '(flycheck-flake8-maximum-line-length 120 t)
 '(flycheck-python-flake8-executable "/usr/local/bin/flake8")
 '(flycheck-python-pycompile-executable "/usr/local/bin/python3")
 '(global-eldoc-mode nil)
 '(groovy-indent-offset 2)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-program-name "hunspell")
 '(ispell-really-hunspell t)
 '(js-indent-level 2)
 '(markdown-command "pandoc -c ~/.pandoc/github.css")
 '(menu-bar-mode nil)
 '(ns-command-modifier 'meta)
 '(org-log-done 'time)
 '(org-todo-keyword-faces
   '(("WAITING" . "Magenta") ("WORKING" . "Cyan") ("CANCELLED" . "Gray")
     ("SOMEDAY" . "SteelBlue")))
 '(org-todo-keywords
   '((sequence "TODO(t)" "WORKING(w)" "WAITING(a)" "SOMEDAY(s)" "|"
               "DONE(d)" "CANCELLED(c)")))
 '(package-selected-packages
   '(helm-lsp lsp-ui lsp-pyright lsp-python-ms leetcode lsp-java lsp-mode
              nginx-mode helm-rg helm-ag meghanada go-mode groovy-mode
              scala-mode yaml-mode markdown-mode dockerfile-mode
              helm-ispell yasnippet python-mode nyan-mode magit
              json-mode helm-pydoc helm-projectile helm-gtags helm
              flycheck exec-path-from-shell auto-complete anzu))
 '(python-mode-hook '(whitespace-mode) t)
 '(python-shell-interpreter "python3")
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(visible-bell nil)
 '(whitespace-style
   '(face tabs spaces trailing lines space-before-tab newline empty
          space-after-tab space-mark tab-mark newline-mark)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "default" :family "MesloLGS NF"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1"))))
 '(whitespace-space ((t (:foreground "grey30"))))
 '(whitespace-tab ((t (:foreground "grey30")))))
