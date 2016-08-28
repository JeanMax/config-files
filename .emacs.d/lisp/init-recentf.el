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
;    Updated: 2016/08/28 16:43:50 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package recentf
  :defines *is-a-server*

  :init
  (setq-default recentf-save-file "~/.emacs.d/misc/recentf")
  (recentf-mode)

  :config
  (setq recentf-max-menu-items 42)
  (setq recentf-max-saved-items 42)
  (when *is-a-server*
    (ignore-errors (recentf-open-files))))


(provide 'init-recentf)
;;; init-recentf.el ends here
