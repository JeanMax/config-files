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
;    Updated: 2020/04/11 19:05:13 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; (account infos in .authinfo)
(use-package gnus
  :defer t
  :commands (gnus)

  :config
  (progn
	(add-hook 'message-mode-hook
			  (lambda ()
				(setq fill-column 80)
				(turn-on-auto-fill)))
	(add-hook 'gnus-message-setup-hook
			  (lambda ()
				(define-key message-mode-map (kbd "C-c C-b") 'email-body)
				(define-key message-mode-map (kbd "C-c C-l") 'email-link)
				(define-key message-mode-map (kbd "C-c C-v") 'email-spell)))
	(add-hook 'gnus-group-mode-hook
			  (lambda ()
				(defalias 'email-delete 'gnus-summary-delete-article)
				(define-key gnus-group-mode-map (kbd "s") 'email-search)
				(define-key gnus-group-mode-map (kbd "g") 'email-check)))

	(setq gnus-posting-styles
		  '(((header "to" "mc.maxcanal@gmail.com") (address "mc.maxcanal@gmail.com"))
			((header "cc" "mc.maxcanal@gmail.com") (address "mc.maxcanal@gmail.com"))

			((header "to" "yodator_9@hotmail.com") (address "yodator_9@hotmail.com"))
			((header "cc" "yodator_9@hotmail.com") (address "yodator_9@hotmail.com"))

			((header "to" "max.canal@unchartech.com") (address "max.canal@unchartech.com"))
			((header "cc" "max.canal@unchartech.com") (address "max.canal@unchartech.com"))

			((header "to" "m.canal@pleiade-am.com") (address "m.canal@pleiade-am.com"))
			((header "cc" "m.canal@pleiade-am.com") (address "m.canal@pleiade-am.com"))))

    (setq gnus-select-method '(nnimap "gmail"
									  (nnimap-address "imap.gmail.com")
									  (nnimap-server-port "imaps")
									  (nnimap-authinfo-file "~/.authinfo")
									  (nnimap-stream ssl)))

    ;; (setq gnus-select-method '(nnmaildir ""
    ;;                                      (directory "/home/mc/Mail/gmail")
    ;;                                      (get-new-mail nil)))

    (setq gnus-message-archive-method nil)

    (setq message-citation-line-function 'message-insert-formatted-citation-line
		  message-citation-line-format "Le %a%e %b %Y à %H:%M, %f a écrit:\n"
		  gnus-save-newsrc-file nil
		  gnus-use-dribble-file nil
		  gnus-agent nil
		  gnus-use-full-window nil
		  gnus-article-skip-boring t
		  send-mail-function 'smtpmail-send-it
		  user-mail-address "mc.maxcanal@gmail.com"
		  user-full-name "Max Canal"
		  smtpmail-smtp-service 587
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

    ;; (require 'nnreddit "~/.emacs.d/site-lisp/nnreddit/nnreddit.el")
    ;; (add-to-list 'gnus-secondary-select-methods
    ;;              '(nnreddit ""))


    ;; Demon to fetch email every 2.5 minutes when Emacs has been idle for 20 seconds
    (use-package gnus-demon
      :defer t
      :config
      (eval-when-compile (require 'gnus-demon))
      (setq gnus-demon-timestep 1))

    (use-package bbdb
	  :ensure t
	  :init
	  (bbdb-initialize 'gnus 'message)
	  (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
	  (bbdb-insinuate-message)

	  :config
	  (setq bbdb-mua-auto-update-p t)
	  (bbdb-mua-auto-update-init 'message)  ; add 'gnus for incoming mail
	  (setq bbdb-message-all-addresses t)
	  ;; ;; once
      ;; (use-package gmail2bbdb
	  ;;   :ensure t
	  ;;   :init
	  ;;   (gmail2bbdb-import-file "~/Downloads/contacts.vcf"))

	  )))


(defun log-mail-count ()
  "Log new mails count in a file."
  (let ((mail-count-file "~/.mail-count")
		(buf-str (with-current-buffer "*Group*" (buffer-string))))
	(if (string-match "[^0-9]*\\([1-9][0-9]*\\).*: .*Tous.*" buf-str)
		(write-region (match-string 1 buf-str) nil mail-count-file)
	  (write-region "" nil mail-count-file))))

(defun gnu ()
  "Launch gnus then gnus-demon (Ok I missed something in the config)..."
  (interactive)
  (gnus)
  (log-mail-count)
  (gnus-demon-add-handler
   '(lambda()
	  (gnus-demon-scan-news)
	  (log-mail-count)
	  (message "*Ninja-Mail-Check @%s!*" (format-time-string "%T")))
   30 5)
  (gnus-demon-init))

(defun email-check ()
  "Check new mails and log mail count."
  (interactive)
  ;; (call-process-shell-command "mbsync -a &" nil 0)
  (gnus-group-get-new-news)
  (log-mail-count))

(defun email-body ()
  "Insert classic mail body."
  (interactive)
  (message-goto-body)
  (insert "Bonjour,\n\n\n\nCordialement,\n\nMax Canal\n")
  (forward-line -5))

(defun email-cr ()
  "Insert classic mail body."
  (interactive)
  (message-goto-to)
  (insert "uncharteam@unchartech.com")
  (replace-string "mc.maxcanal@gmail.com" "max.canal@")
  (message-goto-subject)
  (insert "Projet TODO - " (format-time-string "%d/%m/%Y"))
  (message-goto-body)
  (insert "<#part type=text/html>\n"
		  "<h1>Stock:</h1>\n"
		  "<ul>\n"
		  "  <li>a</li>\n"
		  "  <li>b</li>\n"
		  "  <li>c</li>\n"
		  "</ul>\n"
		  "<h1>Float:</h1>\n"
		  "<ul>\n"
		  "  <li>a</li>\n"
		  "  <li>b</li>\n"
		  "  <li>c</li>\n"
		  "</ul>\n"
		  "<#/part>")
  (message-goto-subject))

(defun email-link (url text)
  "Insert a link (URL + TEXT) in a mail."
  (interactive "surl? \nstext? ")
  (insert "<#part type=text/html><a href=\"" url "\">" text "</a><#/part>"))

(defun email-search ()
  "Search in 'Tous les messages' folder."
  (interactive)
  (switch-to-buffer "*Group*")
  (gnus-group-jump-to-group "[Gmail]/Tous les messages")
  (gnus-group-make-nnir-group nil))

(provide 'init-gnus)
;;; init-gnus.el ends here
