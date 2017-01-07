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
;    Updated: 2017/01/05 14:26:32 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
;; (package-initialize); otherwise Package.el add it...

(when (< emacs-major-version 22)
  (error "Emacs version 22 or greater required!"))

;; tricks to save some startup time + compile config files
;; (defconst initial-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold 50000000)
(defconst initial-file-name-handler-alist file-name-handler-alist)
(add-hook 'after-init-hook '
          (lambda()
            ;; (setq gc-cons-threshold initial-gc-cons-threshold)
            (setq file-name-handler-alist initial-file-name-handler-alist)
            (when (< 23 emacs-major-version)
              (ignore-errors (benchmark-init/activate))
              (byte-recompile-directory "~/.emacs.d/lisp" 0)
              (byte-recompile-directory "~/.emacs.d/site-lisp" 0)
              (message "Init-time: %s" (emacs-init-time)))))
;; (setq gc-cons-threshold 134217728)
(setq file-name-handler-alist nil)
(setq load-prefer-newer t)
;; (setq debug-on-error t)

;; detect emacsclient/os
(defconst *is-a-server* (frame-parameter nil 'client))
(defconst *is-a-mac* (eq system-type 'darwin))

(add-to-list 'load-path "~/.emacs.d/lisp")
;; builtin packages
(require 'init-package) ; need to be 1st
(require 'init-emacs) ;   "    "  "  2nd
(require 'init-simple)
(require 'init-frame)
(require 'init-ibuffer)
(require 'init-kmacro)
(require 'init-etags)
(require 'init-dired)
(require 'init-paren)
(require 'init-hideshow)
(require 'init-recentf)
(require 'init-diff-mode)
(require 'init-tramp)
(require 'init-cc-mode)
(require 'init-erc)
(require 'init-gnus)

;; site-lisp folder
(require 'init-42-mode)
(require 'init-move-mode)
(require 'init-ample-theme)

(when (< 23 emacs-major-version)
  ;; packages to download: package.el not builtin till emacs24... just give up
  (require 'init-benchmark-init)
  (require 'init-ido)
  ;; (require 'init-projectile)
  (require 'init-ace-window)
  (require 'init-rainbow-delimiters)
  (require 'init-highlight-numbers)
  (require 'init-highlight-indent-guides)
  (require 'init-keyfreq)
  (require 'init-emms)
  (require 'init-company)
  (require 'init-git-timemachine)
  (require 'init-diff-hl)
  (require 'init-slime)
  (require 'init-markdown-mode)
  (require 'init-web-mode)
  (require 'init-php-mode)
  (require 'init-yaml-mode)
  (require 'init-tuareg)
  (require 'init-flycheck) ;TODO: do not compile flycheck temp files :/

  ;; not builtin till emacs24
  (require 'init-ruby-mode)
  (require 'init-eww-mode)

  (when (< 22 emacs-major-version)
  ;; not builtin till emacs23
    (require 'init-vc-dir)))


;; auto-generated customizations
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

(provide 'init)
;;; init.el ends here
