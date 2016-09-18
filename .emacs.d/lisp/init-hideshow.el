;;; init-hideshow.el --- init hideshow
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-hideshow.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/11 19:33:21 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package hideshow
  :defer t
  :diminish hs-minor-mode

  :init
  (add-hook 'prog-mode-hook 'hs-minor-mode))

(cond
 ((version< emacs-version "23")
  (bind-key* (kbd "<A-down>") 'hs-toggle-hiding)
  (bind-key* (kbd "<A-left>") 'hs-hide-level)
  (bind-key* (kbd "<A-right>") 'hs-show-all))
 (*is-a-mac*
  (bind-key* (kbd "ESC <down>") 'hs-toggle-hiding)
  (bind-key* (kbd "ESC <left>") 'hs-hide-level)
  (bind-key* (kbd "ESC <right>") 'hs-show-all))
 (t
  (bind-key* (kbd "<M-down>") 'hs-toggle-hiding)
  (bind-key* (kbd "<M-left>") 'hs-hide-level)
  (bind-key* (kbd "<M-right>") 'hs-show-all)))


(provide 'init-hideshow)
;;; init-hideshow.el ends here
