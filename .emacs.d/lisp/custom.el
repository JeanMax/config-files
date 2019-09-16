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
;    Updated: 2019/09/16 14:04:28 by mc               ###   ########.fr        ;
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
 '(gnus-visible-headers
   (quote
    ("^From:" "^Newsgroups:" "^Subject:" "^Date:" "^Followup-To:" "^Reply-To:" "^Organization:" "^Summary:" "^Keywords:" "^To:" "^[BGF]?Cc:" "^Posted-To:" "^Mail-Copies-To:" "^Mail-Followup-To:" "^Apparently-To:" "^Gnus-Warning:" "^Resent-From:" "^X-Sent:" "^X-AnteSpam-Report:")))
 '(flycheck-clang-language-standard "c++17"))


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
