;;; init-mu4e.el --- init mu4e
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-mu4e.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:07:48 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package mu4e
  ;; :ensure t
  :defer t

  :config
  (setq mu4e-maildir "~/Mail")

  (setq mu4e-drafts-folder "/[Gmail].Drafts")
  (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
  (setq mu4e-trash-folder  "/[Gmail].Trash")

  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  (setq mu4e-sent-messages-behavior 'delete)

  ;; setup some handy shortcuts
  ;; you can quickly switch to your Inbox -- press ``ji''
  ;; then, when you want archive some messages, move them to
  ;; the 'All Mail' folder by pressing ``ma''.
  (setq mu4e-maildir-shortcuts
        '( ("/INBOX"               . ?i)
           ("/[Gmail].Sent Mail"   . ?s)
           ("/[Gmail].Trash"       . ?t)
           ("/[Gmail].All Mail"    . ?a)))

  ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "offlineimap")

  ;; something about ourselves
  (setq user-mail-address "mc.maxcanal@gmail.com"
        user-full-name  "Max")

  ;; sending mail
  (setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)
  )

(provide 'init-mu4e)
;;; init-mu4e.el ends here
