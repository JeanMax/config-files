;;; init.el --- init emacs
;;; -*- lexical-binding: t; -*-
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init.el                                            :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    you want with this stuff. If we meet some day, and you     |:: '   :|     ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; compile config files
(add-hook 'after-init-hook
		  (lambda ()
            (recompile-config)
            (setq native-comp-jit-compilation t)))

(defun recompile-config ()
  "Recompile elisp config: `lisp/*.el', `site-lisp/*/*.el'.

   We do not touch init.el, since it would load all the other Lisp
   config-files and eventually crash with some undefined ref.
   Idem for lisp/custom.el, we'll let Emacs manage it."
  (interactive)
  (dolist (config-file
           (nconc (file-expand-wildcards "~/.emacs.d/lisp/init-*.el")
                  (file-expand-wildcards "~/.emacs.d/lisp/lib/[!flycheck]*.el")
                  (file-expand-wildcards "~/.emacs.d/site-lisp/*/[!flycheck]*.el")))
    (byte-recompile-file config-file nil 0)))


(setq load-prefer-newer t)
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/lib")

;; auto-generated customizations
(setq custom-file "~/.emacs.d/lisp/custom.el")
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file)))

;; builtin packages
(require 'init-package) ; need to be 1st
;; (require 'init-elpaca) ; need to be 1st
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
;; (require 'init-42-mode)
(require 'init-move-mode)
(require 'init-ample-theme)

(when (< 23 emacs-major-version)
  ;; external dep (+ lisp package eh)
  (require 'init-slime)

  ;; packages to download: package.el not builtin till emacs24... just give up
  ;; (require 'init-benchmark-init)  ; coment me when done playing around!

  ;; (require 'init-ido)

  (require 'init-vertico)
  (require 'init-orderless)
  (require 'init-marginalia)

  (require 'init-gcmh)
  (require 'init-embark)
  (require 'init-consult)
  (require 'init-ace-window)
  (require 'init-rainbow-delimiters) ; sometimes buggy, but awesome
  (require 'init-highlight-indent-guides)
  (require 'init-keyfreq)
  (require 'init-emms)
  (require 'init-corfu)
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
  (let (term-name (getenv "TERM"))
    (unless (or (string= "dumb" term-name)
                (string= "linux" term-name)) ;; tty
      (require 'init-nerd-icons)))
  (require 'init-treemacs)
  (require 'init-flycheck)
  (require 'init-lsp-mode)
  (require 'init-mistty)

  ;; not builtin till emacs24
  (require 'init-project)
  (require 'init-ruby-mode)
  (require 'init-eww-mode)

  ;; (when (< 22 emacs-major-version)
  ;;   ;; not builtin till emacs23
  ;;   (require 'init-vc-dir))
  )



;; TODO: flex AGR- prefix / complete with symbol at point
(defun jira (ticket)
  "Pouet TICKET."
  (interactive "sAGR-")
  (async-shell-command
   (concat
    "JIRA_API_TOKEN=$(< ~/.jira.token) jira issue view --comments 42 --plain "
    ticket)
   (concat "*AGR-" ticket "*")))


(use-package docker
  :ensure t
  :bind ("C-c d" . docker))


(use-package i3wm-config-mode
  :ensure t)

(use-package groovy-mode
  :ensure t)

(use-package lua-mode
  :ensure t)



(provide 'init)
;;; init.el ends here
