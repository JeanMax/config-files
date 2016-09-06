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
;    Updated: 2016/09/06 00:43:40 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package ample-theme
  :ensure t
  ;; :defer t

  :init
  (load-theme 'ample t t) ; ample{,flat,light}
  (enable-theme 'ample)

  :config
  (set-face-attribute 'minibuffer-prompt t :foreground "blue")
  (set-face-attribute 'region t :background "#424242")
  ;; font-lock-string-face && font-lock-variable-name-face are the same...
  (set-face-attribute 'font-lock-variable-name-face t :foreground "#ebc481")
  (set-face-attribute 'font-lock-string-face t :foreground "#7d7c61")
  (set-face-attribute 'font-lock-doc-face t :foreground "#bdbc61")

  (add-hook 'dired-mode-hook (lambda()
                              (set-face-attribute 'dired-directory nil
                                                  :foreground "#5180b3")
                              (set-face-attribute 'dired-symlink nil
                                                  :foreground "#6aaf50")))
  )
  ;; (set-face-attribute 'match t :inherit bold :foreground "brightred") ; + lazy-highlight? (replace / isearch) + highlight (no idea where it's used, but this is an ugly one)



(provide 'init-ample-theme)
;;; init-ample-theme.el ends here
