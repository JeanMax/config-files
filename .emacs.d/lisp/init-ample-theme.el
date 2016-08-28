;;; init-ample-theme.el --- init ample-theme
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ample-theme.el                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/28 03:10:03 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package ample-theme
  :ensure t
  :defer t

  :init
  (load-theme 'ample t t) ; ample{,flat,light}
  (enable-theme 'ample)

  :config
  (set-face-attribute 'minibuffer-prompt t :foreground "blue")
  (set-face-attribute 'region t :background "#424242")
  ;; font-lock-string-face && font-lock-variable-name-face are the same...
  (set-face-attribute 'font-lock-variable-name-face t :foreground "#EBC481")
  (add-hook 'dired-mode-hook (lambda()
                              (set-face-attribute 'dired-directory t
                                                  :foreground "#5180b3")
                              (set-face-attribute 'dired-symlink t
                                                  :foreground "#6aaf50"))))
  ;; (set-face-attribute 'match t :inherit bold :foreground "brightred") ; + highlight? (replace)




(provide 'init-ample-theme)
;;; init-ample-theme.el ends here
