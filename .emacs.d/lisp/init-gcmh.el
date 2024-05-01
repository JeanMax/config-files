;;; init-gcmh.el --- init gcmh
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-gcmh.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/09/29 14:43:15 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package gcmh
  :ensure t
  :diminish gcmh-mode
  :config
  (gcmh-mode 1)
  ;; (setq gcmh-idle-delay 30)
  (setq gcmh-high-cons-threshold initial-gc-cons-threshold)
  (setq gcmh-verbose t)
  (setq garbage-collection-messages t))


(provide 'init-gcmh)
;;; init-gcmh.el ends here
