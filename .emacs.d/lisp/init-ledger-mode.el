;;; init-ledger-mode.el --- init ledger-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ledger-mode.el                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2017/03/28 13:35:39 by mc                #+#    #+#              ;
;    Updated: 2018/02/18 12:07:27 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package ledger-mode
  :defer t
  :ensure t
  :mode ("\\.ledger\\'" . ledger-mode)
  )

(bind-key (kbd "C-c b") (lambda () (interactive) (insert "₿")))

;; from emacs-wiki
(defun ledger-add-entry (title in amount out) ;TODO: debug
  (interactive
   (let ((accounts (mapcar 'list (ledger-accounts))))
     (list (read-string "Entry: " (format-time-string "%Y-%m-%d " (current-time)))
           (let ((completion-regexp-list "^Expenses:"))
             (ido-completing-read "What did you pay for? " accounts))
           (read-string "How much did you € ")
           (let ((completion-regexp-list "^Assets:"))
             (ido-completing-read "Where did the money come from? " accounts)))))
  (insert title)
  (newline)
  (indent-to 4)
  (insert in "  " amount)
  (newline)
  (indent-to 4)
  (insert out))

(provide 'init-ledger-mode)
;;; init-ledger-mode.el ends here
