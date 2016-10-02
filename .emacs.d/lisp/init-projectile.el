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
;    Updated: 2016/09/20 23:31:03 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package projectile
  :ensure t
  :defer t

  :config
  (define-prefix-command 'u-map)
  (global-set-key (kbd "ù") 'u-map)
  (define-key projectile-mode-map (kbd "ù") 'projectile-command-map)
  (projectile-global-mode 1))

(provide 'init-projectile)
;;; init-projectile.el ends here
