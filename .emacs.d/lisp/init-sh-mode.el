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
;    Updated: 2018/06/12 11:34:37 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; sh-mode is in "C-source-code",
;; so use-package throw a "no such file" (but works...)
(use-package sh-script
  :defer t
  :mode
  ("PKGBUILD\\'" . sh-mode)
  ("\\.install\\'" . sh-mode))


(use-package makefile-mode
  :mode
  ("Makefile\\.*" . makefile-mode)
  (".*\\.mk" . makefile-mode))

(provide 'init-sh-mode)
;;; init-sh-mode.el ends here
