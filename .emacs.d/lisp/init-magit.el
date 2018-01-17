;;; init-magit.el --- init magit
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-magit.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2017/03/28 13:35:39 by mc                #+#    #+#              ;
;    Updated: 2018/01/15 10:28:44 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package magit
  :ensure t
  ;; :defer t

  ;; :init

  :config
  (set-face-attribute 'magit-diff-file-heading t :foreground "blue" :weight 'bold))

(bind-key* (kbd *altgr-v*) 'magit-status)

(provide 'init-magit)
;;; init-magit.el ends here
