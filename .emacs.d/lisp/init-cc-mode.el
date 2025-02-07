;;; init-cc-mode.el --- init cc-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-cc-mode.el                                     :+:      :+:    :+:   ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/05/07 11:29:56 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package cc-mode
  :defer t

  :mode
  ("\\.tpp$" . c++-mode)

  :config
  (setq-default c-basic-offset 4)
  (setq-default c-default-style "linux")
  (setq indent-tabs-mode nil)

  (add-hook 'c++-mode-hook
            (lambda ()
              (c-set-offset 'inclass '++))))

(bind-key* (kbd "C-c C-g") 'headcomment)
(bind-key* (kbd "M-è") 'main) ; 7
(bind-key* (kbd "M-;") 'semi-c)


(defun main ()
  "Insert a C main."
  (interactive)
  ;; (insert "int\t\tmain(int ac, char **av, char **env)\n{\n\t\n\treturn (EXIT_SUCCESS);\n}\n")
  (insert "int\t\tmain(int, char **)\n{\n\t\n\treturn 0;\n}\n")
  (previous-line 3)
  (forward-char 1))

(defun semi-c ()
  "Semi-colon at end of line, without moving!"
  (interactive)
  (save-excursion
    (move-end-of-line nil)
    (insert ";")))

(defun headcomment ()
  "Head comment."
  (interactive)
  (newline)
  (insert "/*")
  (newline)
  (insert "** ")
  (newline)
  (insert "*/")
  (previous-line 2)
  (forward-char 4))

(provide 'init-cc-mode)
;;; init-cc-mode.el ends here
