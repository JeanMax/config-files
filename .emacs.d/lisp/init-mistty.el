;;; init-mistty.el --- init mistty
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-mistty.el                                       :+:      :+:    :+:  ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:08:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
;; (use-package mistty
;;   :ensure t
;;   :defer t
;;   :init
;;   ;; (require 'altgr)
;;   ;; (bind-key* (kbd *altgr-s*) 'mistty)
;;   :config
;;   (keymap-set mistty-prompt-map "C-c C-r" 'mistty-send-ctrl-r)
;;   (keymap-set mistty-prompt-map "C-c C-s" 'mistty-send-ctrl-s)
;;   (keymap-set mistty-prompt-map "C-c C-f" 'mistty-sudo)
;;   (keymap-set mistty-prompt-map "C-c C-b" 'mistty-create-buffer-with-output))

;; (defun mistty-send-ctrl-r ()
;;   "Send Ctrl-r to the terminal."
;;   (interactive)
;;   (mistty-send-key 1 (kbd "C-r")))

;; (defun mistty-send-ctrl-s ()
;;   "Send Ctrl-s to the terminal."
;;   (interactive)
;;   (mistty-send-key 1 (kbd "C-s")))



(use-package eat
  :ensure t
  :defer t
  :init
  (require 'altgr)
  (bind-key* (kbd *altgr-s*) 'eat)
  :config
  '(eat-buffer-name "*shell*"))

;; TODO: add something to toggle C-c C-l <-> C-c C-jj
;;       add something to eval a line / region / buffer


(provide 'init-mistty)
;;; init-mistty.el ends here
