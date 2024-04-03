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
;    Updated: 2017/04/21 16:52:21 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(use-package ample-theme
  :ensure t
  :init
  (load-theme 'ample t t) ; ample{,flat,light}
  (enable-theme 'ample)

  :config
  (set-face-attribute 'minibuffer-prompt t :foreground ample/light-blue)
  (set-face-attribute 'region t :background "#424242")
  ;; font-lock-string-face && font-lock-variable-name-face are the same...
  (set-face-attribute 'default t :foreground ample/fg :background "gray13")
  (set-face-attribute 'font-lock-variable-name-face t :foreground "#b8b74b")
  (set-face-attribute 'font-lock-string-face t :foreground ample/dark-tan)
  (set-face-attribute 'font-lock-doc-face t :foreground ample/tan)
  (set-face-attribute 'highlight t :background ample/orange)
  (set-face-attribute 'lazy-highlight t :foreground ample/orange :weight 'bold)
  (set-face-attribute 'match t :foreground ample/orange))


(provide 'init-ample-theme)
;;; init-ample-theme.el ends here
