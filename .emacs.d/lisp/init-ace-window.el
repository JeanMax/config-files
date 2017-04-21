;; init-ace-window.el --- init ace-window
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ace-window.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/04/06 14:14:59 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;


;;; Code:
(use-package ace-window
  :ensure t
  :defer t

  :init
  (bind-key (kbd "µ") 'ace-window)
;;   (define-prefix-command 'u-map)
;;   (bind-key (kbd "µ") 'u-map)
;;   (bind-key (kbd "µ µ") '(lambda () (interactive)
;; 						   (insert "µ")))
;;   (bind-key (kbd "µ ?") '(lambda () (interactive)
;; 						   (message "x - delete window
;; m - swap (move) window
;; v - split window vertically
;; b - split window horizontally
;; n - select the previous window
;; i - maximize window (select which window)
;; o - maximize current window")))

  ;;TODO: bind windmove-{right,left,up,down}
  :config
  (setq aw-dispatch-always t)
  (setq aw-keys '(?a ?z ?e ?r ?t ?y ?u)))


(provide 'init-ace-window)
;;; init-ace-window.el ends here
