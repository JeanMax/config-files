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
;    Updated: 2016/09/17 19:48:46 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package php-mode
  :ensure t

  :mode
  ("\\.php\\'" . php-mode)
  
  :config
  (progn
    (setq indent-tabs-mode nil) ; (cause it inherits c-hook...)

    (use-package php-eldoc
      :ensure t
      :defer t

      :init
      (add-hook 'php-mode-hook 'php-eldoc-enable))))


(provide 'init-php-mode)
;;; init-php-mode.el ends here
