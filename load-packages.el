;; (require 'cl)
(require 'cl-lib)

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    anzu
    auto-complete
    exec-path-from-shell
    helm
    helm-ag
    highlight-symbol
    json-mode
    magit
    markdown-mode
    nyan-mode
    python-mode
    rainbow-delimiters
    yaml-mode
    lsp-pyright
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
