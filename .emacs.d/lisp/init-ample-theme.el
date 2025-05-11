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
;    you want with this stuff. If we meet some day, and you     |:: '   :|     ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(use-package ample-theme
  :ensure t
  :config
  (load-theme 'ample t t) ; ample{,flat,light}
  (enable-theme 'ample)
  (require 'palette)
  (unpackaged/customize-theme-faces
    'ample
    ;; from set-face syntax to custom-set-face:
    ;; (set-face-attribute '\([a-z-]+\) \(t\|nil\) \(.*\)) → '(\1 ((nil (\3)))))

    ;; --- builtin: ---

    ;; standard font lock
    `(minibuffer-prompt ((nil (:foreground ,ample/light-blue))))
    `(region ((nil (:background ,ample/darker-gray))))
    ;; trying to have the same background than term
    `(default ((nil (:foreground ,ample/fg :background "gray14"))))
    ;; `(default ((nil (:foreground unspecified :background unspecified))))
    ;; font-lock-string-face && font-lock-variable-name-face are the same...
    `(font-lock-variable-name-face ((nil (:foreground ,ample/another-tan))))
    `(font-lock-string-face ((nil (:foreground ,ample/dark-tan))))
    `(font-lock-doc-face ((nil (:foreground ,ample/tan))))
    `(highlight ((nil (:background ,ample/darker-gray))))
    `(lazy-highlight ((nil (:foreground ,ample/orange :weight bold))))
    `(match ((nil (:foreground ,ample/orange))))
    `(error ((nil (:foreground ,ample/dark-red :weight bold))))
    `(success ((nil (:foreground ,ample/dark-green :weight bold))))
    `(warning ((nil (:foreground ,ample/orange :weight bold))))
    `(custom-button-unraised ((t (:weight bold))))
    `(cursor ((t (:background ,ample/fg))))

    ;; ansi-color (used in compilation / grep / comint / shell ...)
    `(ansi-color-black ((nil (:background ,ample/darker-gray :foreground ,ample/darker-gray))))
    `(ansi-color-blue ((nil (:background ,ample/blue :foreground ,ample/blue))))
    `(ansi-color-cyan ((nil (:background ,ample/lighter-blue :foreground ,ample/lighter-blue))))
    `(ansi-color-green ((nil (:background ,ample/green :foreground ,ample/green))))
    `(ansi-color-magenta ((nil (:background ,ample/purple :foreground ,ample/purple))))
    `(ansi-color-red ((nil (:background ,ample/red :foreground ,ample/red))))
    `(ansi-color-white ((nil (:background ,ample/fg :foreground ,ample/fg))))
    `(ansi-color-yellow ((nil (:background ,ample/yellow :foreground ,ample/yellow))))

    ;; could find something a bit more subtle
    `(ansi-color-bright-black ((nil (:weight bold :inherit ansi-color-black))))
    `(ansi-color-bright-blue ((nil (:weight bold :inherit ansi-color-blue))))
    `(ansi-color-bright-cyan ((nil (:weight bold :inherit ansi-color-cyan))))
    `(ansi-color-bright-green ((nil (:weight bold :inherit ansi-color-green))))
    `(ansi-color-bright-magenta ((nil (:weight bold :inherit ansi-color-magenta))))
    `(ansi-color-bright-red ((nil (:weight bold :inherit ansi-color-red))))
    `(ansi-color-bright-white ((nil (:weight bold :inherit ansi-color-white))))
    `(ansi-color-bright-yellow ((nil (:weight bold :inherit ansi-color-yellow))))

    ;; dired-mode
    `(dired-directory ((nil (:foreground ,ample/blue))))
    `(dired-symlink ((nil (:foreground ,ample/green))))

    ;; hl-line-mode
    `(hl-line ((nil (:extend nil :background ,ample/darker-gray))))

    ;; erc
    `(erc-input-face ((nil (:foreground ,ample/red))))
    `(erc-notice-face ((nil (:foreground ,ample/rb5))))
    `(erc-keyword-face ((nil (:background ,ample/green))))

    ;; ido
    `(ido-first-match ((nil (:foreground ,ample/salmon))))
    `(ido-subdir ((nil (:foreground ,ample/blue))))


   ;; --- not builtin: ---

   ;; ido-grid-mode
   `(ido-grid-mode-match ((nil (:weight bold))))

   ; magit
   `(magit-section-highlight ((nil (:background ,ample/region))))
   `(magit-diff-file-heading ((nil (:foreground ,ample/blue :weight bold))))

   ;; diff-hl-mode
   `(diff-hl-change
     ((nil (:background ,ample/darker-gray :foreground ,ample/orange :weight bold))))
   `(diff-hl-delete
     ((nil (:background ,ample/darker-gray :foreground ,ample/red :weight bold))))
   `(diff-hl-insert
     ((nil (:background ,ample/darker-gray :foreground ,ample/green :weight bold))))

   ;; treemacs
   `(treemacs-directory-face ((nil (:inherit 'dired-directory)))) ; ample/blue
   `(treemacs-git-conflict-face ((nil (:foreground ,ample/dark-red))))
   `(treemacs-git-modified-face ((nil (:foreground ,ample/orange))))

   ;; vertico
   `(vertico-current ((nil (:extend t :background ,ample/darker-gray))))

   ;; ledger-mode
   `(ledger-font-xact-highlight-face ((nil (:background "brightblack"))))

   ;; flycheck
   `(flycheck-error ((nil (:underline t :background ,ample/darker-red))))
   `(flycheck-warning ((nil (:background ,ample/darker-red))))
   `(flycheck-info ((nil (:underline t))))


   )

  )



(provide 'init-ample-theme)
;;; init-ample-theme.el ends here
