;;; init-treemacs.el --- init treemacs
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-treemacs.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    you want with this stuff. If we meet some day, and you     |:: '   :|     ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package treemacs
  :ensure t
  :no-require t
  ;; :defer t
  :commands (treemacs lsp-treemacs-errors-list)

  :init
  (bind-key* (kbd "<f1>") 'treemacs)

  ;; :config
  ;; (treemacs-project-follow-mode)
  )


(use-package treemacs-magit
  :after treemacs
  :ensure t)

(provide 'init-treemacs)
;;; init-treemacs.el ends here
