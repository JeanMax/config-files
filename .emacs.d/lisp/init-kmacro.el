;;; init-kmacro.el --- init kmacro
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-kmacro.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/25 16:28:44 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package kmacro
  :defer t

  :config

  (defun toggle-macro ()
    "Toggle macro recording."
    (interactive)
    (if (null defining-kbd-macro)
        (kmacro-start-macro nil) (kmacro-end-macro nil)))

  (bind-key* (kbd "<f6>") 'toggle-macro)
  ;(bind-key* (kbd *altgr-x*) 'kmacro-end-and-call-macro)
  )

(provide 'init-kmacro)
;;; init-kmacro.el ends here
