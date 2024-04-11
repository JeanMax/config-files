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
;    Updated: 2018/02/18 12:08:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(use-package treemacs
  :ensure t
  :no-require t
  ;; :defer t
  :commands (treemacs lsp-treemacs-errors-list)

  :custom-face
  (treemacs-directory-face ((t (:inherit dired-directory)))) ; ample/blue
  (treemacs-git-conflict-face ((t (:foreground "#9d2512")))) ; ample/dark-red
  (treemacs-git-modified-face ((t (:foreground "#dF9522")))) ; ample/orange

  :init
  (bind-key* (kbd "<f1>") 'treemacs))


(use-package treemacs-magit
  :after treemacs
  :ensure t)

(provide 'init-treemacs)
;;; init-treemacs.el ends here
