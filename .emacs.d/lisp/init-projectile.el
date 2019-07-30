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
;    Updated: 2019/03/22 09:17:24 by unchartech_5     ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package projectile
  :ensure t
  ;; :defer t

  :config
  (define-key projectile-mode-map (kbd "£") 'projectile-command-map)
  (projectile-global-mode 1)
  (setq projectile-enable-caching t) ; laggy?
  ;; (setq projectile-cache-file "/home/mc/.emacs.d/misc/projectile.cache")
  (unless *is-a-server*
    (setq projectile-known-projects-file "/tmp/projectile-bookmarks.eld"))
  (setq projectile-mode-line
   (quote
	(:eval
	 (if
		 (file-remote-p default-directory)
		 " Proj"
	   (format " Proj[%s]"
			   (projectile-project-name))))))
  (setq projectile-switch-project-action (lambda nil (projectile-ibuffer 0))))

(provide 'init-projectile)
;;; init-projectile.el ends here
