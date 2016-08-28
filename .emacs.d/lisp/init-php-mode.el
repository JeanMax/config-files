;;; init-php-mode.el --- init php-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-php-mode.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/29 00:59:59 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package php-mode
  :ensure t

  :mode
  ("\\.php\\'" . php-mode)
  
  :config
  (setq indent-tabs-mode nil)) ; (cause it inherits c-hook...)


(provide 'init-php-mode)
;;; init-php-mode.el ends here
