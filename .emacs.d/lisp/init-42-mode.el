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
;    Updated: 2018/02/18 11:43:27 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package 42-mode
  :defer t

  :load-path
  "~/.emacs.d/site-lisp/42"

  :init
  (require 'header))

(provide 'init-42-mode)
;;; init-42-mode.el ends here
