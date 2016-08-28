;;; init-tuareg.el --- init tuareg
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-tuareg.el                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/29 00:59:41 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package tuareg
  :ensure t

  :mode
  ("\\.ml\\'" . tuareg-mode)
  ("\\.mli\\'" . tuareg-mode))


(provide 'init-tuareg)
;;; init-tuareg.el ends here
