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
;    Updated: 2017/03/20 23:26:51 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-width t)
 '(eww-bookmarks-directory "~/.emacs.d/misc")
 '(flycheck-c/c++-clang-executable "clang++ -std=c++11")
 '(package-selected-packages
   (quote
	(projectile flycheck tuareg yaml-mode php-eldoc php-mode web-mode markdown-mode diff-hl git-timemachine company-statistics company emms keyfreq highlight-indent-guides highlight-numbers rainbow-delimiters ace-window ido-grid-mode ido-complete-space-or-hyphen smex ido-ubiquitous benchmark-init slime use-package)))
 '(url-configuration-directory "~/.emacs.d/misc/url/"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'custom)
;;; custom.el ends here
