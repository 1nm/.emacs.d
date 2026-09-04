;;; custom.el --- Variables and faces saved by `M-x customize'  -*- lexical-binding: t -*-
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
 '(auto-save-timeout 10)
 '(custom-enabled-themes '(wheatgrass))
 '(ediff-split-window-function 'split-window-horizontally)
 '(global-eldoc-mode nil)
 '(groovy-indent-offset 2)
 '(indent-tabs-mode nil)
 '(ispell-program-name "hunspell")
 '(ispell-really-hunspell t)
 '(js-indent-level 2)
 '(markdown-command "pandoc -c ~/.pandoc/github.css")
 '(ns-command-modifier 'meta)
 '(org-log-done 'time)
 '(org-todo-keyword-faces
   '(("WAITING" . "Magenta") ("WORKING" . "Cyan") ("CANCELLED" . "Gray")
     ("SOMEDAY" . "SteelBlue")))
 '(org-todo-keywords
   '((sequence "TODO(t)" "WORKING(w)" "WAITING(a)" "SOMEDAY(s)" "|"
               "DONE(d)" "CANCELLED(c)")))
 '(package-selected-packages
   '(anzu helm helm-ag json-mode markdown-mode nyan-mode rainbow-delimiters
          yaml-mode))
 '(python-mode-hook '(whitespace-mode) t)
 '(python-shell-interpreter "python3")
 '(ring-bell-function 'ignore)
 '(show-paren-mode t)
 '(tab-width 2)
 '(visible-bell nil)
 '(whitespace-style
   '(face tabs spaces trailing lines space-before-tab newline empty
          space-after-tab space-mark tab-mark newline-mark)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "default" :family "MesloLGS NF"))))
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
;;; custom.el ends here
