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
  (require 'palette)
  (unpackaged/customize-theme-faces
   'ample

   ;; from set-face syntax to custom-set-face:
   ;; (set-face-attribute '\([a-z-]+\) \(t\|nil\) \(.*\)) → '(\1 ((nil (\3)))))

   ;; --- builtin: ---

   ;; standard font lock
   '(minibuffer-prompt ((nil (:foreground "ample/light-blue"))))
   '(region ((nil (:background "ample/darker-gray"))))
   ;; font-lock-string-face && font-lock-variable-name-face are the same...
   ;; '(default ((nil (:foreground "ample/fg" :background "gray13"))))
   '(default ((nil (:foreground "ample/fg" :background unspecified))))
   '(font-lock-variable-name-face ((nil (:foreground "ample/another-tan"))))
   '(font-lock-string-face ((nil (:foreground "ample/dark-tan"))))
   '(font-lock-doc-face ((nil (:foreground "ample/tan"))))
   '(highlight ((nil (:background "ample/darker-gray"))))
   '(lazy-highlight ((nil (:foreground "ample/orange" :weight bold))))
   '(match ((nil (:foreground "ample/orange"))))

   ;; dired-mode
   '(dired-directory ((nil (:foreground "ample/blue"))))
   '(dired-symlink ((nil (:foreground "ample/green"))))

   ;; hl-line-mode
   '(hl-line ((nil (:extend nil :background "ample/darker-gray"))))

   ;; erc
   '(erc-input-face ((nil (:foreground "ample/red"))))
   '(erc-notice-face ((nil (:foreground "ample/rb5"))))
   '(erc-keyword-face ((nil (:background "ample/green"))))

    ;; ido
   '(ido-first-match ((nil (:foreground "ample/salmon"))))
   '(ido-subdir ((nil (:foreground "ample/blue"))))


   ;; --- not builtin: ---

   ;; ido-grid-mode
   '(ido-grid-mode-match ((nil (:weight bold))))

   ; magit
   '(magit-section-highlight ((nil (:background "ample/region"))))
   '(magit-diff-file-heading ((nil (:foreground "ample/blue" :weight bold))))

   ;; diff-hl-mode
   '(diff-hl-change ((nil (:background "ample/darker-gray" :foreground "ample/orange" :weight bold))))
   '(diff-hl-delete ((nil (:background "ample/darker-gray" :foreground "ample/red" :weight bold))))
   '(diff-hl-insert ((nil (:background "ample/darker-gray" :foreground "ample/green" :weight bold))))

   ;; treemacs
   '(treemacs-directory-face ((nil (:inherit 'dired-directory)))) ; ample/blue
   '(treemacs-git-conflict-face ((nil (:foreground "ample/dark-red"))))
   '(treemacs-git-modified-face ((nil (:foreground "ample/orange"))))

   ;; vertico
   '(vertico-current ((nil (:extend t :background "ample/darker-gray"))))

   ;; ledger-mode
   '(ledger-font-xact-highlight-face ((nil (:background "brightblack"))))

   ))



(provide 'init-ample-theme)
;;; init-ample-theme.el ends here
