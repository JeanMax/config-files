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
;    Updated: 2018/03/23 11:28:46 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package flycheck
  :ensure t
  :defer t
  :diminish flycheck-mode

  :init
  (add-hook 'prog-mode-hook 'global-flycheck-mode)

  (use-package flycheck-ledger
    :defer t
    :ensure t)

  :config
  ;; (setq flycheck-mode-line-prefix "f")

  (setq flycheck-clang-include-path
        '("/home/mc/quarantedeux/corewar/test/include"
          "/home/mc/quarantedeux/corewar/test/minunit"
          "/home/mc/quarantedeux/corewar/include"
          "/home/mc/quarantedeux/corewar/include/asm"
          "/home/mc/quarantedeux/corewar/libft/include/libft"
          "/home/mc/quarantedeux/corewar/libft/include"))


  ;; (setq flycheck-clang-language-standard "-std=c++11")
  ;; (setq flycheck-clang-args '("-std=c++11"))
  (setq flycheck-clang-warnings '("all" "extra" "-D LINUX"))
  ;; (setq flycheck-idle-change-delay 2)
  (setq flycheck-check-syntax-automatically
        '(save
          mode-enabled
          new-line)))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
