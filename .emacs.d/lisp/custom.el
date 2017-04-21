;;; custom.el --- init php-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    custom.el                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/04/05 17:15:06 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-width t)
 '(dabbrev-case-distinction nil)
 '(dabbrev-case-fold-search nil)
 '(dabbrev-case-replace nil)
 '(eww-bookmarks-directory "~/.emacs.d/misc")
 '(hippie-expand-dabbrev-skip-space t)
 '(hippie-expand-try-functions-list
   (quote
	(try-expand-list try-expand-line try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(ido-grid-mode t)
 '(package-selected-packages
   (quote
	(gtags ggtags flx-ido projectile flycheck tuareg yaml-mode php-eldoc php-mode web-mode markdown-mode diff-hl git-timemachine company-statistics company emms keyfreq highlight-indent-guides highlight-numbers rainbow-delimiters ace-window ido-grid-mode ido-complete-space-or-hyphen smex ido-ubiquitous benchmark-init slime use-package)))
 '(projectile-cache-file "/home/mc/.emacs.d/misc/projectile.cache")
 '(projectile-known-projects-file "/home/mc/.emacs.d/misc/projectile-bookmarks.eld")
 '(projectile-mode-line
   (quote
	(:eval
	 (if
		 (file-remote-p default-directory)
		 " Proj"
	   (format " Proj[%s]"
			   (projectile-project-name))))))
 '(projectile-switch-project-action (lambda nil (projectile-ibuffer 0)))
 '(url-configuration-directory "~/.emacs.d/misc/url/"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#bdbdb3" :background "gray13"))))
 '(font-lock-variable-name-face ((t (:foreground "#b8b74b")))))

(provide 'custom)
;;; custom.el ends here
