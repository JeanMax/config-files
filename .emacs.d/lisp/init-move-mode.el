;;; init-move-mode.el --- init move-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-move-mode.el                                     :+:      :+:    :+:   ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/25 16:13:31 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package move-mode
  :load-path
  "~/.emacs.d/site-lisp/move")

(bind-key* (kbd *altgr-i*) 'move-mode)

(bind-key* (kbd "M-i") 'previous-line)
(bind-key* (kbd "M-j") 'left-char)
(bind-key* (kbd "M-k") 'next-line)
(bind-key* (kbd "M-l") 'right-char)
(bind-key* (kbd "M-u") 'left-word)
(bind-key* (kbd "M-o") 'right-word)
(bind-key* (kbd "M-m") 'normdown)
(bind-key* (kbd "M-p") 'normup)
(bind-key* (kbd "M-_") 'move-beginning-of-line) ; 8
(bind-key* (kbd "M-ç") 'move-end-of-line) ; 9
(bind-key* (kbd "<home>") 'backward-page)
(bind-key* (kbd "<end>") 'forward-page)

(bind-key* (kbd "M-g") 'goto-line)


(defun normdown()
  "normdown"
  (interactive)
  (next-line 24))

(defun normup()
  "normup"
  (interactive)
  (previous-line 24))

(provide 'init-move-mode)
;;; init-move-mode.el ends here
