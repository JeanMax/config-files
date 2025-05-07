;;; init-slime.el --- init slime
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-slime.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    you want with this stuff. If we meet some day, and you     |:: '   :|     ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package slime
  :ensure t
  ;; :defer t

  ;; :init
  ;; (load (expand-file-name "~/.roswell/helper.el"))

  :config
  (slime-setup '(slime-fancy))
  (setq slime-contribs '(slime-fancy))
  ;; (setq inferior-lisp-program /"usr/bin/sbcl")
  ;; (setq inferior-lisp-program "ros -Q run")
  (setq inferior-lisp-program "ros -Q -l ~/.sbclrc -L sbcl-bin run")
  (setq slime-load-failed-fasl 'never)
  (define-key slime-repl-mode-map (kbd "C-c r")
    'slime-repl-previous-matching-input)
  (define-key slime-repl-mode-map (kbd "TAB")
    'slime-complete-symbol)
  (bind-key (kbd "C-c )") 'slime-close-all-parens-in-sexp))


(provide 'init-slime)
;;; init-slime.el ends here
