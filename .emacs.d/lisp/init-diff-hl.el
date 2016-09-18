;;; init-diff-hl.el --- init diff-hl
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-diff-hl.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/11 14:10:47 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package diff-hl
  :ensure t
  :defer t

  :init
  (add-hook 'after-init-hook 'diff-hl-margin-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (when (version<= "24.4" emacs-version)
    (add-hook 'prog-mode-hook 'diff-hl-flydiff-mode))
  ;; (add-hook 'prog-mode-hook 'diff-hl-mode) ;disabled in prog-mode

  :config
  (when (version<= "24.4" emacs-version)
    (setq diff-hl-flydiff-mode t))
  (setq diff-hl-highlight-function nil)
  (set-face-attribute 'diff-hl-insert t :background "green" :foreground "white")
  (set-face-attribute 'diff-hl-delete t :background "red" :foreground "white")
  (set-face-attribute 'diff-hl-change t :background "color-130" :foreground "white"))

(bind-key* (kbd "C-c C-d") 'diff-hl-mode)

(provide 'init-diff-hl)
;;; init-diff-hl.el ends here
