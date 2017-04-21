;;; init-sh-mode.el --- init sh-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-sh-mode.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/03/27 12:21:32 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package sh-mode
  :mode
  ("PKGBUILD\\'" . sh-mode)
  ("\\.install\\'" . sh-mode)

  :defer t)

(provide 'init-sh-mode)
;;; init-sh-mode.el ends here
