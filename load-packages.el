;; (require 'cl)
(require 'cl-lib)

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    anzu
    helm
    helm-ag
    json-mode
    markdown-mode
    nyan-mode
    rainbow-delimiters
    yaml-mode
    ))

(defun is-all-packages-installed ()
  (cl-loop for p in required-packages
        when (not (package-installed-p p)) do (cl-return nil)
        finally (cl-return t)))

(unless (is-all-packages-installed)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))
