;;; init-paren.el --- init paren
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-paren.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/28 03:46:16 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package paren
  :defer t

  :init
  (add-hook 'prog-mode-hook 'show-paren-mode)

  :config
  (defadvice show-paren-function
      (after show-matching-paren-offscreen activate)
    "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
    (interactive)
    (let* ((cb (char-before (point)))
           (matching-text (and cb
                               (char-equal (char-syntax cb) ?\) )
                               (blink-matching-open))))
      (when matching-text (message matching-text))))

  (setq show-paren-delay 0.1))


(provide 'init-paren)
;;; init-paren.el ends here
