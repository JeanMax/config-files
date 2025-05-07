;;; custom.el --- some room for emacs-generated config
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    custom.el                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2020/04/08 10:59:41 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(emms-player-list '(emms-player-vlc emms-player-vlc-playlist))
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(flycheck-pylintrc "~/Documents/code/d2glf/setup.cfg")
 '(gnus-visible-headers
   '("^From:" "^Newsgroups:" "^Subject:" "^Date:" "^Followup-To:" "^Reply-To:" "^Organization:" "^Summary:" "^Keywords:" "^To:" "^[BGF]?Cc:" "^Posted-To:" "^Mail-Copies-To:" "^Mail-Followup-To:" "^Apparently-To:" "^Gnus-Warning:" "^Resent-From:" "^X-Sent:" "^X-AnteSpam-Report:"))
 '(js-indent-level 4)
 '(magit-diff-refine-hunk t)
 '(package-selected-packages
   '(gradle-mode csharp-mode luarocks lua-mode dotnet csv-mode go-mode dumb-jump inf-ruby highlight-numbers benchmark-init flycheck-ledger flycheck-grammalecte utop flycheck-ocaml merlin tuareg ledger-mode yaml-mode rjsx-mode json-mode js2-mode php-eldoc php-mode web-mode markdown-mode diff-hl git-timemachine magit company-statistics company emms keyfreq highlight-indent-guides rainbow-delimiters ace-window projectile ido-grid-mode smex flx-ido ido-completing-read+ slime bbdb flycheck-cython cython-mode gtags ggtags diminish use-package)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-subtree-depth-1-face ((t (:background "green"))))
 '(dired-subtree-depth-2-face ((t (:background "#bdbc61"))))
 '(dired-subtree-depth-3-face ((t (:background "red")))))

(provide 'custom)
;;; custom.el ends here
