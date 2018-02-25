;;; init-magit.el --- init magit
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-magit.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2017/03/28 13:35:39 by mc                #+#    #+#              ;
;    Updated: 2018/02/25 10:53:40 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package magit
  :ensure t
  :defer t

  ;; :init

  :config
  (setq magit-merge-arguments '("--no-ff"))
  (setq magit-fetch-arguments '("--prune"))
  (setq magit-log-arguments '("--graph" "--color" "--decorate" "-n256"))

  (set-face-attribute 'magit-section-highlight t :background "#303030")
  (set-face-attribute 'magit-diff-file-heading t :foreground "blue" :weight 'bold))

(bind-key* (kbd *altgr-v*) 'magit-status)

(provide 'init-magit)
;;; init-magit.el ends here
