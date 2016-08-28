;;; init-web-mode.el --- init web-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-web-mode.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/29 00:59:45 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package web-mode
  :ensure t

  :mode
  ("\\.html\\'" . web-mode)
  ("\\.twig\\'" . web-mode)
  ("\\.css\\'" . web-mode)
  
  :config
  (setq indent-tabs-mode nil)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-indent-style 4))



(provide 'init-web-mode)
;;; init-web-mode.el ends here
