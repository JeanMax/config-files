;;; init-treemacs.el --- init treemacs
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-treemacs.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:08:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(use-package treemacs
  :ensure t
  :defer t
  :config
  (set-face-attribute 'treemacs-directory-face t :inherit dired-directory)
  (set-face-attribute 'treemacs-git-conflict-face t :foreground ample/dark-red)
  (set-face-attribute 'treemacs-git-modified-face t :foreground ample/orange))

(bind-key* (kbd "<f1>") 'treemacs)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(provide 'init-treemacs)
;;; init-treemacs.el ends here
