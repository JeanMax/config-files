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
;    Updated: 2016/08/24 23:09:13 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package highlight-indent-guides
  :ensure t
  :defer t

  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

  :config
  (setq highlight-indent-guides-method 'column)
  (set-face-attribute 'highlight-indent-guides-character-face t :foreground "color-241"))


(provide 'init-highlight-indent-guides)
;;; init-highlight-indent-guides.el ends here
