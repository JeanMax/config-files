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
;    Updated: 2019/03/19 09:15:55 by unchartech_5     ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package magit
  :ensure t
  :defer t

  :config
  ;; (when *is-a-server*
  ;;   (magit-status))
  (setq magit-merge-arguments '("--no-ff"))
  (setq magit-fetch-arguments '("--prune"))
  (setq magit-log-arguments '("--graph" "--color" "--decorate" "-n256"))
  (setq magit-diff-refine-hunk t)
  (setq magit-diff-refine-ignore-whitespace nil))

(require 'altgr)
(bind-key* (kbd *altgr-v*) 'magit-status)

(provide 'init-magit)
;;; init-magit.el ends here
