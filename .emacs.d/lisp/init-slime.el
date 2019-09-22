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
;    Updated: 2019/08/16 10:17:41 by mc               ###   ########.fr        ;
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
  (setq inferior-lisp-program "ros -Q -l ~/.sbclrc -L sbcl run") ;TODO: symlink
  (setq slime-load-failed-fasl 'never)
  (bind-key (kbd "C-c )") 'slime-close-all-parens-in-sexp))


(provide 'init-slime)
;;; init-slime.el ends here
