(require 'cl)

(require 'package)

(add-to-list 'package-archives
                          '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    anzu
    auto-complete
    coffee-mode
    dockerfile-mode
    exec-path-from-shell
    flycheck
    go-mode
    gradle-mode
    groovy-mode
    helm
    helm-ag
    helm-gtags
    ;; helm-projectile
    helm-pydoc
    highlight-symbol
    json-mode
    magit
    markdown-mode
    nyan-mode
    python-mode
    dockerfile-mode
    markdown-mode
    rainbow-delimiters
    scala-mode
    yaml-mode
    yasnippet
    ))

(defun is-all-packages-installed ()
  (loop for p in required-packages
    when (not (package-installed-p p)) do (return nil)
      finally (return t)))

(unless (is-all-packages-installed)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))
