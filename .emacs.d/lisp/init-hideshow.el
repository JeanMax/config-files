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
;    Updated: 2018/02/18 12:06:40 by mc               ###   ########.fr        ;
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
 (t
  (bind-key* (kbd "ESC <down>") 'hs-toggle-hiding)
  (bind-key* (kbd "ESC <left>") 'hs-hide-level)
  (bind-key* (kbd "ESC <right>") 'hs-show-all)

  ;we keep this for gui-macs
  (bind-key* (kbd "<M-down>") 'hs-toggle-hiding)
  (bind-key* (kbd "<M-left>") 'hs-hide-level)
  (bind-key* (kbd "<M-right>") 'hs-show-all)))



(use-package origami
  :defer t
  :ensure t

  :init
  (add-hook 'yaml-mode-hook 'origami-mode))

(cond
 ((version< emacs-version "23")
  (bind-key* (kbd "<A-down>") 'origami-toggle-node)
  (bind-key* (kbd "<A-left>") 'origami-show-only-node)
  (bind-key* (kbd "<A-right>") 'origami-toggle-all-nodes))
 (t
  (bind-key* (kbd "ESC <down>") 'origami-toggle-node)
  (bind-key* (kbd "ESC <left>") 'origami-show-only-node)
  (bind-key* (kbd "ESC <right>") 'origami-toggle-all-nodes)

  ;we keep this for gui-macs
  (bind-key* (kbd "<M-down>") 'origami-toggle-node)
  (bind-key* (kbd "<M-left>") 'origami-show-only-node)
  (bind-key* (kbd "<M-right>") 'origami-toggle-all-nodes)))





(provide 'init-hideshow)
;;; init-hideshow.el ends here
