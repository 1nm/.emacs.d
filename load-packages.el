(require 'cl)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    auto-complete
    yasnippet
    nyan-mode
    helm
    helm-projectile
    anzu
    python-mode
    flycheck
    auto-highlight-symbol
    ))

(defun is-all-packages-installed ()
  (loop for p in required-packages
    when (not (package-installed-p p)) do (return nil)
      finally (return t)))

(unless (is-all-packages-installed)
  (package-refresh-contents)
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))
