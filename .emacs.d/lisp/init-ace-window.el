;;; init-ace-window.el --- init ace-window
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ace-window.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/17 19:20:14 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;; x - delete window
;; m - swap (move) window
;; v - split window vertically
;; b - split window horizontally
;; n - select the previous window
;; i - maximize window (select which window)
;; o - maximize current window

;;; Code:
(use-package ace-window
  :ensure t
  :defer t

  :init
  (bind-key (kbd "ø") 'ace-window) ;altrg o

  :config
  (setq aw-dispatch-always t)
  (setq aw-keys '(?a ?z ?e ?r ?t ?y ?u)))

(provide 'init-ace-window)
;;; init-ace-window.el ends here
