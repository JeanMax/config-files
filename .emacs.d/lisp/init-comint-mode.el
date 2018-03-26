;;; init-comint-mode.el --- init comint-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-comint-mode.el                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 11:41:57 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package comint-mode
  :defer t

  :init
  (setq gdb-many-windows t)
  (setq gdb-show-threads-by-default t)

  ;; :config
  (add-hook 'comint-mode-hook
            '(lambda ()
               (define-key comint-mode-map (kbd "C-c r") 'comint-history-isearch-backward))))


(provide 'init-comint-mode)
;;; init-comint-mode.el ends here
