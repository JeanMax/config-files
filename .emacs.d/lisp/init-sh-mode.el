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
;    Updated: 2018/02/18 12:24:19 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; TODO: sh-mode is in "C-source-code",
;; so use-package throw a "no such file" (but works...)
(use-package sh-mode
  :defer t
  :mode
  ("PKGBUILD\\'" . sh-mode)
  ("\\.install\\'" . sh-mode))

(provide 'init-sh-mode)
;;; init-sh-mode.el ends here
