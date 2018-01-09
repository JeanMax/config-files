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
;    Updated: 2017/08/25 14:59:15 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package web-mode
  :ensure t

  :mode
  ("\\.html\\'" . web-mode)
  ("\\.twig\\'" . web-mode)
  ("\\.css\\'" . web-mode)
  ("\\.ejs\\'" . web-mode)

  :config
  ;; (setq indent-tabs-mode nil)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  ;; (setq web-mode-indent-style 4)

  (setq web-mode-engines-alist
      '(("django" . "\\.html\\'"))))



(provide 'init-web-mode)
;;; init-web-mode.el ends here
