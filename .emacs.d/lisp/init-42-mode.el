;;; init-42-mode.el --- init 42-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-42-mode.el                                     :+:      :+:    :+:   ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/01/27 10:51:42 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package 42-mode
  :load-path
  "~/.emacs.d/site-lisp/42"

  :init
  (require 'header))

(provide 'init-42-mode)
;;; init-42-mode.el ends here
