;;; init-gnus.el --- init gnus
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-gnus.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/28 23:57:27 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; (account infos in .authinfo)
(use-package gnus
  :functions gnus-demon-add-handler
  :defer t

  :config
  (progn
    (setq send-mail-function (quote smtpmail-send-it))
    (setq gnus-select-method
          '(nnimap "gmail"
                   (nnimap-address "imap.gmail.com")
                   (nnimap-server-port "imaps")
                   (nnimap-stream ssl)))
    (setq
     gnus-summary-line-format "%U%R%z %(%&user-date;  %-21,21f  %B%s%)\n"
     gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
     gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
     gnus-thread-sort-functions '(gnus-thread-sort-by-number
                                  (not gnus-thread-sort-by-date)))

    ;; Demon to fetch email every 5 minutes when Emacs has been idle for 1 minutes
    (eval-when-compile (require 'gnus-demon))
    (gnus-demon-add-handler '(lambda()
                              (gnus-demon-scan-news)
                              (message "*Ninja-Mail-Check!*"))
                            5 1)))


(provide 'init-gnus)
;;; init-gnus.el ends here