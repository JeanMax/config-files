;;; init-yaml-mode.el --- init yaml-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-yaml-mode.el                                  :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:09:17 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package yaml-mode
  :defer t
  :ensure t

  :mode
  ("\\.yml\\'" . yaml-mode))


(provide 'init-yaml-mode)
;;; init-yaml-mode.el ends here
