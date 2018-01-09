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
;    Updated: 2017/10/09 19:29:49 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package flycheck
  :ensure t
  ;; :defer t
  :diminish flycheck-mode

  :init
  (add-hook 'prog-mode-hook 'global-flycheck-mode)

  (use-package flycheck-ledger
    :ensure t)

  :config
  ;; (setq flycheck-mode-line-prefix "f")
  (setq flycheck-clang-include-path
        '("/home/mc/quarantedeux/nibbler/core/inc"
          "/home/mc/quarantedeux/nibbler/core/inc/argv_parser"
          "/home/mc/quarantedeux/nibbler/core/inc/game"
		  "/home/mc/quarantedeux/nibbler/core/test/inc"
		  "/home/mc/quarantedeux/nibbler/core/test/minunit"))
  ;; (setq flycheck-clang-language-standard "-std=c++11")
  ;; (setq flycheck-clang-args '("-std=c++11"))
  (setq flycheck-clang-warnings '("all" "extra"))
  ;; (setq flycheck-idle-change-delay 2)
  (setq flycheck-check-syntax-automatically
        '(save
          mode-enabled
          new-line)))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
