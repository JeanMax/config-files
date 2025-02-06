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
;    Updated: 2019/09/16 14:10:07 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
;; (package-initialize); otherwise Package.el add it...

(when (< emacs-major-version 22)
  (error "Emacs version 22 or greater required!"))

;; tricks to save some startup time
;; ( https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/ )
;; (let ((gc-cons-threshold most-positive-fixnum))
(defconst initial-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)

(add-hook 'minibuffer-setup-hook
		  #'(lambda () (setq gc-cons-threshold most-positive-fixnum)))
(add-hook 'minibuffer-exit-hook
		  #'(lambda () (setq gc-cons-threshold initial-gc-cons-threshold)))

;; compile config files
(defconst initial-file-name-handler-alist file-name-handler-alist)
(add-hook 'after-init-hook
		  #'(lambda ()
			 ;; (setq gc-cons-threshold initial-gc-cons-threshold)
			 (setq file-name-handler-alist initial-file-name-handler-alist)
			 (when (< 23 emacs-major-version)
			   (ignore-errors (benchmark-init/activate))
			   (byte-recompile-directory "~/.emacs.d/lisp" 0)
			   (byte-recompile-directory "~/.emacs.d/site-lisp" 0)
			   (message "Init-time: %s" (emacs-init-time)))))
(setq file-name-handler-alist nil)
(setq load-prefer-newer t)
;; (setq debug-on-error t)


;; detect emacsclient/os
(defconst *is-a-server*
  (let ((prev_cmd (getenv "_")))
	(if (eq nil prev_cmd)
		nil
		(string-equal "emacsclient" (file-name-nondirectory prev_cmd)))))
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-rxvt* (string-equal "urxvtc" (getenv "TERMINAL")))

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
(require 'init-sh-mode)
(require 'init-python-mode)
(require 'init-erc)
(require 'init-gnus)
(require 'init-comint-mode)
(require 'init-desktop)

;; site-lisp folder
(require 'init-42-mode)
(require 'init-move-mode)
(require 'init-ample-theme)

(when (< 23 emacs-major-version)
  ;; external dep (+ lisp package eh)
  ;; (require 'init-mu4e)
  (require 'init-slime)

  ;; packages to download: package.el not builtin till emacs24... just give up
  ;; (require 'init-benchmark-init)  ; coment me when done playing around!
  (require 'init-ido)
  (require 'init-projectile)
  (require 'init-ace-window)
  (require 'init-rainbow-delimiters) ; sometimes buggy, but awesome
  ;; (require 'init-highlight-numbers) ; buggy
  (require 'init-highlight-indent-guides)
  (require 'init-keyfreq)
  (require 'init-emms)
  (require 'init-company)
  (require 'init-magit)
  (require 'init-git-timemachine)
  (require 'init-diff-hl)
  (require 'init-markdown-mode)
  (require 'init-web-mode)
  (require 'init-php-mode)
  (require 'init-js-mode)
  (require 'init-yaml-mode)
  (require 'init-ledger-mode)
  (require 'init-tuareg)
  (require 'init-flycheck) ;TODO: do not compile flycheck temp files :/

  ;; not builtin till emacs24
  (require 'init-ruby-mode)
  (require 'init-eww-mode)
  (require 'init-ispell)

  ;; (when (< 22 emacs-major-version)
  ;;   ;; not builtin till emacs23
  ;;   (require 'init-vc-dir))
  )


;; auto-generated customizations
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

(provide 'init)
;;; init.el ends here
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
