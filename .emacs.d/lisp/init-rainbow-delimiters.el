;;; init-rainbow-delimiters.el --- init rainbow-delimiters
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-rainbow-delimiters.el                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/16 23:22:12 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package rainbow-delimiters
  :ensure t
  :defer t

  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))



(provide 'init-rainbow-delimiters)
;;; init-rainbow-delimiters.el ends here
