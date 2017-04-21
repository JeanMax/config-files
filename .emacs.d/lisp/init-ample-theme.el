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
;    Updated: 2017/03/27 10:34:29 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package ample-theme
  :load-path "~/.emacs.d/site-lisp/ample-theme"

  ;; :init
    ;; (clone-package "ample-theme" "https://github.com/jordonbiondo/ample-theme"))


  ;; (load-theme 'ample t t) ; ample{,flat,light}
  ;; (enable-theme 'ample)

  :config
  (set-face-attribute 'minibuffer-prompt t :foreground "#528fd1")
  (set-face-attribute 'region t :background "#424242")
  ;; font-lock-string-face && font-lock-variable-name-face are the same...
  (set-face-attribute 'font-lock-variable-name-face t :foreground "#b0b74b")
  (set-face-attribute 'font-lock-string-face t :foreground "#7d7c61")
  (set-face-attribute 'font-lock-doc-face t :foreground "#bdbc61")
  (set-face-attribute 'highlight t :background "#dF9522")
  (set-face-attribute 'lazy-highlight t :foreground "#dF9522" :weight 'bold)
  (set-face-attribute 'match t :foreground "#dF9522"))


(provide 'init-ample-theme)
;;; init-ample-theme.el ends here
