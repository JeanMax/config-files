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
;    Updated: 2018/02/18 12:18:10 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package tramp
  :defer t

  :config
  (setq tramp-default-method "rsync")
  (setq tramp-histfile-override "/dev/null")
  (setq tramp-auto-save-directory "/tmp"))


(provide 'init-tramp)
;;; init-tramp.el ends here
