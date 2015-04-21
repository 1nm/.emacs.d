(require 'cl)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    anzu
    auto-complete
    auto-highlight-symbol
    exec-path-from-shell
    flycheck
    helm
    helm-gtags
    helm-projectile
    helm-pydoc
    json-mode
    nyan-mode
    python-mode
    yasnippet
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
