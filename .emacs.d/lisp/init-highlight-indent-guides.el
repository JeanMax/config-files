;;; init-highlight-indent-guides.el --- init highlight-indent-guides
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-highlight-indent-guides.el                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/25 16:18:56 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package highlight-indent-guides
  :ensure t
  :defer t
  :commands (highlight-indent-guides-mode)

  ;; :init
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode) ;that thing fuck up the syntax highlighting :/

  :config
  (setq highlight-indent-guides-method 'column)
  (set-face-attribute 'highlight-indent-guides-character-face t :foreground "color-241"))

;; (when (version< "23" emacs-version)
  ;; (bind-key* (kbd *altgr-h*) 'highlight-indent-guides-mode))

(provide 'init-highlight-indent-guides)
;;; init-highlight-indent-guides.el ends here
