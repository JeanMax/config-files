;;; init-js-mode.el --- init js-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-js-mode.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/12/08 13:19:56 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package js-mode
  :defer t

  :mode
  ("\\.js\\'" . js-mode)
  ("\\.json\\'" . js-mode)
  ("\\.dbl\\'" . js-mode)
  ("\\.dbj\\'" . js-mode))


(provide 'init-js-mode)
;;; init-js-mode.el ends here
