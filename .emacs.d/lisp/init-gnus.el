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
;    Updated: 2018/02/18 12:21:14 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; (account infos in .authinfo)
(use-package gnus
  :defer t
  :commands (gnus)

  :init
  (defun gnu ()
    "Launch gnus then gnus-demon (Ok I missed something in the config)..."
    (interactive)
    (gnus)
    (gnus-demon-add-handler '(lambda()
                               (gnus-demon-scan-news)
                               ;; (gnus-group-get-new-news)
                               (message "*Ninja-Mail-Check @%s!*"
                                        (format-time-string "%T")))
                            150 20)
    (gnus-demon-init))


  :config
  (progn
    (setq gnus-save-newsrc-file nil)
    (setq gnus-use-dribble-file nil)
    (setq gnus-agent nil)
    (setq gnus-use-full-window nil)
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

    ;; (use-package nnredit
    ;;   :load-path
    ;;   "~/.emacs.d/site-lisp/nnreddit"

    ;;   :init
    ;;   (add-to-list 'gnus-secondary-select-methods
    ;;                '(nnreddit "")))

    ;; Demon to fetch email every 2.5 minutes when Emacs has been idle for 20 seconds
    (use-package gnus-demon
      :defer t

      :config
      (eval-when-compile (require 'gnus-demon))
      (setq gnus-demon-timestep 1))))


(provide 'init-gnus)
;;; init-gnus.el ends here
