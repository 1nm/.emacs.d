;;; early-init.el --- Runs before package.el and before the first frame  -*- lexical-binding: t -*-

;;; Garbage collection
;; Effectively disable GC while starting up; init.el restores a sane value
;; from `emacs-startup-hook' once everything is loaded.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;;; File name handlers
;; Every `load'/`require' consults `file-name-handler-alist' (tramp, jka-compr,
;; ...).  Nothing needs them during startup, so skip the lookups.
(defvar my/saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 32 1024 1024)
                  gc-cons-percentage 0.1
                  file-name-handler-alist my/saved-file-name-handler-alist)))

;;; Package system
;; Let package.el activate installed packages itself (it does so right after
;; this file, before init.el).  `package-quickstart' concatenates every
;; package's autoloads into one precompiled file, package-quickstart.el, so
;; startup loads one file instead of one per package.  It is regenerated
;; automatically whenever a package is installed or removed.
(setq package-enable-at-startup t
      package-quickstart t)

;;; Native compilation
(setq native-comp-async-report-warnings-errors 'silent)

;;; Initial frame
;; Configure the frame before it is created so it is drawn once, with the
;; final size and without toolbar/scrollbars, instead of being resized.
(setq frame-inhibit-implied-resize t)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(width . 200) default-frame-alist)
(push '(height . 80) default-frame-alist)
(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)

;;; Startup screen
(setq inhibit-startup-screen t
      initial-scratch-message nil)

;;; early-init.el ends here
