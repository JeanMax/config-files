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
;    Updated: 2016/09/05 22:52:31 by mcanal           ###   ########.fr        ;
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


;; detect enemacsclient/os
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
(require 'init-emacs)
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
(require 'init-keyfreq)
(require 'init-company)
(require 'init-git-timemachine)
(require 'init-diff-hl)
(require 'init-highlight-indent-guides)
(require 'init-web-mode)
(require 'init-php-mode)
(require 'init-yaml-mode)
(require 'init-tuareg)
(require 'init-flycheck) ;TODO: do not compile flycheck temp files :/

;; auto-generated customizations
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)


;; function history (cf elisp-functions.el) FIXME
(defvar tags-make-n-visit-history '("--regex='/.*\\(public\\|static\\|abstract\\|protected\\|private\\).*function.*(/' ~/Pliizz/src/**/*.php"))
(eval-after-load "savehist"
  '(add-to-list 'savehist-additional-variables 'tags-make-n-visit-history))
(setq savehist-file "~/.emacs.d/misc/history")
(savehist-mode 1)

(setq eshell-history-file-name "~/.emacs.d/misc/misc/eshell/history")

;; eww/erc I guess...
(setq nsm-settings-file "~/.emacs.d/misc/network-security.data")
;; eww
(setq url-configuration-directory  "~/.emacs.d/misc/url/")
(setq url-cookie-file "~/.emacs.d/misc/misc/url/cookies")
(setq eww-search-prefix
	  "https://www.startpage.com/do/dsearch?cat=web&pl=opensearch&language=english&query=")


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

;; format line number (fringe)
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

