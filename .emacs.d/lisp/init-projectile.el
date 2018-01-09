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
;    Updated: 2017/07/30 23:37:17 by mc               ###   ########.fr        ;
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
  ;; (setq projectile-known-projects-file "/home/mc/.emacs.d/misc/projectile-bookmarks.eld")
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
