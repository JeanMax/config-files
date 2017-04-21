;;; init-projectile.el --- init projectile
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-projectile.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/04/05 14:51:27 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package projectile
  :ensure t
  :defer t

  :config
  (define-key projectile-mode-map (kbd "£") 'projectile-command-map)
  ;; (projectile-global-mode 1) ; laggy
  (setq projectile-enable-caching t))

(provide 'init-projectile)
;;; init-projectile.el ends here
