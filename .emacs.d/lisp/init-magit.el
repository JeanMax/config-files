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


;; TODO: this is laggy as fuck (gc? or is it just git? or gcmh???)
;; (use-package magit-todos
;;   :ensure t
;;   :after magit
;;   :config
;;   (setq magit-todos-exclude-globs
;;        '(".git/" "build" ".cache" ".mypy_cache" ".pytest_cache" ".ruff_cache" "docker/files" "*.tar.*" "*.pyc" "__pycache__"))
;;   (setq magit-todos-keywords '("TODO" "FIXME" "HACK" "DEBUG" "TEMP"))  ; seems to be ignored (hl-todo-keyword-faces is used instead?)
;;   (setq magit-todos-ignored-keywords '("NOTE" "DONE" "FAIL"))  ; this works
;;   (setq magit-todos-update nil)
;;   (setq ediff-window-setup-function 'ediff-setup-windows-plain)
;;   (magit-todos-mode 1))



(require 'altgr)
(bind-key* (kbd *altgr-v*) 'magit-status)

(provide 'init-magit)
;;; init-magit.el ends here
