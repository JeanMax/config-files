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
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(flycheck-clang-language-standard "c++17")
 '(gnus-visible-headers
   (quote
    ("^From:" "^Newsgroups:" "^Subject:" "^Date:" "^Followup-To:" "^Reply-To:" "^Organization:" "^Summary:" "^Keywords:" "^To:" "^[BGF]?Cc:" "^Posted-To:" "^Mail-Copies-To:" "^Mail-Followup-To:" "^Apparently-To:" "^Gnus-Warning:" "^Resent-From:" "^X-Sent:" "^X-AnteSpam-Report:")))
 '(js-indent-level 4)
 '(package-selected-packages
   (quote
    (rjsx-mode slime csv-mode jsx-mode dockerfile-mode autodisass-llvm-bitcode sass-mode json-mode inf-ruby yaml-mode web-mode utop use-package tuareg smex rainbow-delimiters projectile php-mode php-eldoc markdown-mode magit ledger-mode keyfreq js2-mode ido-grid-mode ido-completing-read+ ido-complete-space-or-hyphen highlight-numbers highlight-indent-guides gtags git-timemachine ggtags flycheck-ocaml flycheck-ledger flycheck-cython flx-ido emms diminish diff-hl cython-mode company-statistics benchmark-init ace-window))))


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
