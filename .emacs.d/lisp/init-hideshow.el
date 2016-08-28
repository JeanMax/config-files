;;; init-hideshow.el --- init hideshow
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-hideshow.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/28 05:06:16 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package hideshow
  :defer t
  :diminish hs-minor-mode

  :init
  (add-hook 'prog-mode-hook 'hs-minor-mode))



(provide 'init-hideshow)
;;; init-hideshow.el ends here
