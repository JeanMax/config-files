;;; init-flycheck.el --- init flycheck
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-flycheck.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/06 00:17:18 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package flycheck
  :ensure t
  :defer t
  :diminish flycheck-mode

  :init
  (add-hook 'prog-mode-hook 'global-flycheck-mode)
  
  :config
  ;; (setq flycheck-mode-line-prefix "f")
  (setq flycheck-clang-include-path
		'("../../../../../../../usr/include/SDL"
		  "../inc"
		  "../../inc"
		  "../libft/inc"
		  "../../libft/inc")) ; -.-
  (setq flycheck-clang-warnings
		'("all"
		  "extra"
		  "error"))
  ;; (setq flycheck-check-syntax-automatically
  ;; 		'(save
  ;; 		  mode-enabled
  ;; 		  new-line))
  (setq flycheck-idle-change-delay 2))


(provide 'init-flycheck)
;;; init-flycheck.el ends here
