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
;    Updated: 2018/01/15 11:15:05 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; TODO: sh-mode is in "C-source-code",
;; so use-package throw a "no such file" (but works...)
(use-package sh-mode
  :mode
  ("PKGBUILD\\'" . sh-mode)
  ("\\.install\\'" . sh-mode)

  :defer t)

(provide 'init-sh-mode)
;;; init-sh-mode.el ends here
