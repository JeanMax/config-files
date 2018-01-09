;;; init-recentf.el --- init recentf
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-recentf.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/07/30 23:38:30 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package recentf
  :defer t

  :config
  ;; (setq-default recentf-save-file "~/.emacs.d/misc/recentf")
  (recentf-mode)
  (setq recentf-max-menu-items 42)
  (setq recentf-max-saved-items 42)
  ;; (when *is-a-server*
  ;; (ignore-errors (recentf-open-files)))
  )

;; (bind-key* (kbd *altgr-r*) 'recentf-open-files) ; I use this actually :/

(provide 'init-recentf)
;;; init-recentf.el ends here
