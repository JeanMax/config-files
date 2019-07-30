;;; init-tramp.el --- init tramp
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-tramp.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/05/03 21:00:31 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package tramp
  :defer t

  :config
  ;; (setq tramp-default-method "rsync")
  (setq tramp-default-method "ssh")
  (setq tramp-histfile-override "/dev/null")
  (setq tramp-auto-save-directory "/tmp"))

(defun fuck ()
  "Permission denied? Fuck."
  (interactive)
  (let ((position (point)))
	(find-alternate-file
	 (concat
	  (if (string-match "^/ssh:.+:.+" default-directory)
		  (replace-regexp-in-string
		   "^/.+:.+\\(:\\).+"
		   (concat "|sudo:root@" (file-remote-p default-directory 'host) ":")
		   (or (buffer-file-name) default-directory)
		   nil nil 1)
		(concat "/sudo::" (or (buffer-file-name) default-directory)))))
	(goto-char position)))

(provide 'init-tramp)
;;; init-tramp.el ends here
