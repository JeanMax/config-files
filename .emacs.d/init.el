;;; init.el --- init emacs
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init.el                                            :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/29 01:01:54 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; tricks to save some startup time
(defconst initial-gc-cons-threshold gc-cons-threshold)
(defconst initial-file-name-handler-alist file-name-handler-alist)
(add-hook 'after-init-hook '
          (lambda()
            (setq gc-cons-threshold initial-gc-cons-threshold)
            (setq file-name-handler-alist initial-file-name-handler-alist)
            (message "Init-time: %s" (emacs-init-time))))


;; detect emacsclient
(defconst *is-a-server* (string-equal "emacsclient"
                                      (file-name-nondirectory (getenv "_"))))

(defconst *is-a-mac* (eq system-type 'darwin))


(setq gc-cons-threshold 134217728)
(setq file-name-handler-alist nil)
;; (setq debug-on-error t)

;; tell emacs where to read abbrev
(setq save-abbrevs 'silently)
(setq abbrev-file-name "~/.emacs.d/misc/abbrev_defs")

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
;; (setq use-package-always-ensure t)
(when *is-a-server*
  (setq use-package-verbose t))
;; (require 'bind-key)
;; (require 'diminish)

;; compile config
(setq load-prefer-newer t)
(add-hook 'after-init-hook (lambda ()
                             (byte-recompile-directory "~/.emacs.d/lisp" 0)
                             (byte-recompile-directory "~/.emacs.d/site-lisp" 0)))

;; external config
(add-to-list 'load-path "~/.emacs.d/site-lisp/42")
(require 'header)

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'elisp-functions)
(require 'keybinding)

;; builtin packages
(require 'init-erc)
(require 'init-gnus)
(require 'init-ibuffer)
(require 'init-hideshow)
(require 'init-paren)
(require 'init-recentf)
(require 'init-diff)
(require 'init-cc-mode)
(require 'init-ruby-mode)

;; packages to download
(require 'init-ample-theme)
(require 'init-company)
(require 'init-flycheck)
(require 'init-git-timemachine)
(require 'init-diff-hl)
(require 'init-highlight-indent-guides)
(require 'init-web-mode)
(require 'init-php-mode)
(require 'init-tuareg)

;; auto-generated customizations
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)


;; function history (cf elisp-functions.el)
(defvar tags-make-n-visit-history '("--regex='/.*\\(public\\|static\\|abstract\\|protected\\|private\\).*function.*(/' ~/Pliizz/src/**/*.php"))
(eval-after-load "savehist"
  '(add-to-list 'savehist-additional-variables 'tags-make-n-visit-history))
(setq savehist-file "~/.emacs.d/misc/history")
(savehist-mode 1)

;; eww/erc I guess...
(setq nsm-settings-file "~/.emacs.d/misc/network-security.data")
(setq url-configuration-directory  "~/.emacs.d/misc/url/")
(setq url-cookie-file "~/.emacs.d/misc/misc/url/cookies")

(setq eshell-history-file-name "~/.emacs.d/misc/misc/eshell/history")


;; encoding
(set-language-environment "UTF-8")

;; indentation
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ; set to true later for c-mode
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq fill-column 80)

;; disable top menu bar
(menu-bar-mode -1)


;; (defun right-padding (str len)
;;   "Padd a string STR with space to the right (till total length >= LEN)."
;;   (let ((space-len (- len (length str))))
;;     (if (> space-len 0)
;;         (concat str (make-string space-len ? ))
;;       str)))

(defun shorten-directory (dir max-length)
  "DIR... Show up to MAX-LENGTH characters of a directory name DIR."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

(defun extra-shorten-directory (dir)
  "MOAR DIR!"
  (shorten-directory
   (replace-regexp-in-string (expand-file-name "~") "~" dir)
   30))
        
;; mode line customization (bottom bar)
(setq-default mode-line-format
              '("%e"
                ;TODO: and what if it's read-only And Mofified? (do we even care?!)
                (:eval (propertize " %b " 'face
                                   (cond ((eql buffer-read-only t)
                                          '(:foreground "black" :background "#5180b3" :weight bold))
                                         ((buffer-modified-p)
                                          '(:foreground "black" :background "#dF9522" :weight bold))
                                         (t
                                          '(:foreground "black"  :background "#6aaf50" :weight bold)))))
                ;; (vc-mode vc-mode)
                (:propertize "%4l:")
                (:eval (propertize (format "%-3s" (format-mode-line "%c")) 'face
                                   (when (> (current-column) 80)
                                       '(:background "#cd5542"))))
                (:eval (propertize  (if (frame-parameter nil 'client) "@" " ") 'face
                                   (when flycheck-current-errors
                                     '(:background "#cd5542"))))
                (:propertize "%6p")
                (flycheck-mode flycheck-mode-line)
                "     "
                (:eval (propertize (extra-shorten-directory default-directory) 'face '(:weight bold)))
                "   "
                mode-line-modes
                mode-line-misc-info))

;; col/line number
(column-number-mode 1)
(setq linum-format "%3d ")

;; Ignore case when completing file/buffer names
(setq read-file-name-completion-ignore-case 't)
(setq read-buffer-completion-ignore-case 't)

;; Increase number of undo
(setq undo-limit 100000)

;; no problem
(setq large-file-warning-threshold nil)

;; restore session (buffers, frames...)

(when *is-a-server*
  (desktop-save-mode 1)
  (setq desktop-save nil)
  (setq desktop-path '("~/.emacs.d/misc/")))

;; backup (files.el ... TODO: use-package?)
(setq backup-directory-alist `((".*" . ,"~/.emacs.d/backup")))
(setq auto-save-list-file-prefix "~/.emacs.d/misc/auto-save-list/.saves-")
(setq auto-save-file-name-transforms `((".*" ,"~/.emacs.d/backup" t)))
(setq delete-old-versions 42) ;never delete or ask stuff about deleting my precious backups!
(setq kept-new-versions 42)
;; (setq kept-old-versions 42)
(setq version-control t)


;; line wrap
(setq-default fill-column 80)
(setq-default truncate-partial-width-windows 40)

;; limit mouse selection to active window
;; TODO; do not move the cursor...
;; (xterm-mouse-mode)

;; window splitting at launch
(setq split-height-threshold 40)
(setq split-width-threshold 25)
;; (setq window-min-height 15)
;; (setq window-min-width 15)

;; selecting region with shift
(transient-mark-mode t)

;; bookmark
;; (setq inhibit-splash-screen t)
(when *is-a-server*
  (bookmark-bmenu-list))
(setq bookmark-file "~/.emacs.d/misc/bookmarks")

;; version-control stuffs
(setq vc-follow-symlinks t)
(when *is-a-server*
  (ignore-errors (vc-dir default-directory)))
;; (message "---%s---" (if (null buffer-file-name)
                        ;; dired-directory
                      ;; (file-name-directory buffer-file-name)))))

(provide 'init)
;;; init.el ends here

