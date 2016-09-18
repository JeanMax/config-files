;;; init-tramp.el --- init tramp
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-tramp.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/18 19:51:32 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package tramp
  :defer t

  :config
  (setq tramp-default-method "rsync")
  (setq tramp-auto-save-directory "\"/tmp\""))


(provide 'init-tramp)
;;; init-tramp.el ends here
