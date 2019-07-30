;;; init-ispell.el --- init ispell
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ispell.el                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mc <mc.maxcanal@gmail.com>                 +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2019/03/13 16:03:05 by mc                #+#    #+#              ;
;    Updated: 2019/03/14 01:36:15 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(use-package ispell
  :init
  (setenv "DICPATH" "/usr/share/hunspell")
  (setq ispell-program-name "/usr/bin/hunspell")
  (setq ispell-local-dictionary-alist
		'(("fr_FR"
		   "[[:alpha:]]"
		   "[^[:alpha:]]"
		   "[']"
		   t
		   ("-d" "fr_FR")
		   nil
		   iso-8859-1)
		  ("en_US"
		   "[[:alpha:]]"
		   "[^[:alpha:]]"
		   "[']"
		   t
		   ("-d" "en_US")
		   nil
		   iso-8859-1)))
  (setq ispell-dictionary "en_US"))

(use-package flyspell
  :init
  ;; (global-set-key (kbd "<f8>") 'ispell-word)
  ;; (global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
  ;; (global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
  ;; (global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
  ;; (global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)
  (setq flyspell-issue-message-flag nil)
  (setq flyspell-issue-welcome-flag nil)
  ;; (dolist (hook '(c-mode-hook c++-mode-hook))
  ;;   (add-hook hook (lambda () (flyspell-prog-mode))))
  (dolist (hook '(text-mode-hook))
    (add-hook hook (lambda () (unless (flyspell-mode 1) (flyspell-mode 1)))))
  (dolist (hook '(change-log-mode-hook log-edit-mode-hook message-mode-hook))
    (add-hook hook (lambda () (flyspell-mode -1)))))

(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))

(defun email-spell ()
  "Correct spelling in new mail."
  (interactive)
  ;; (goto-line 6)
  (let ((dic ispell-dictionary))
	(setq ispell-dictionary "fr_FR")
	(ispell-region 106 (point-max))
	(setq ispell-dictionary dic)))


(provide 'init-ispell)
;;; init-ispell.el ends here
