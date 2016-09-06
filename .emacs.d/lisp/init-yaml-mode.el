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
;    Updated: 2016/08/30 11:08:22 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package yaml-mode
  :ensure t

  :mode
  ("\\.yml\\'" . yaml-mode))


(provide 'init-yaml-mode)
;;; init-yaml-mode.el ends here
