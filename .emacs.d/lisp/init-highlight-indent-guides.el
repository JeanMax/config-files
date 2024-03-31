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
;    Updated: 2018/02/18 12:06:44 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package highlight-indent-guides
  :ensure t
  :defer t
  :diminish t
  :commands (highlight-indent-guides-mode)

  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

  :config
  (progn
    (setq highlight-indent-guides-method 'column)
    (setq highlight-indent-guides-auto-character-face-perc 50)
    (setq highlight-indent-guides-auto-even-face-perc 40)
    (setq highlight-indent-guides-auto-odd-face-perc 30)))

;; (when (version< "23" emacs-version)
  ;; (bind-key* (kbd *altgr-h*) 'highlight-indent-guides-mode))

(provide 'init-highlight-indent-guides)
;;; init-highlight-indent-guides.el ends here
