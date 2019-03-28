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
;    Updated: 2019/03/20 19:04:34 by unchartech_5     ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package flycheck
  :ensure t
  :defer t
  :diminish flycheck-mode

  :init
  (add-hook 'prog-mode-hook 'global-flycheck-mode)

  (setq flycheck-grammalecte-enabled-modes
		'(mail-mode message-mode))
  ;; (flycheck-grammalecte-download-grammalecte) ;once
  (use-package flycheck-grammalecte
    ;; :defer t
    :ensure t
	:init
	(setq flycheck-grammalecte-report-esp nil)
	(setq flycheck-grammalecte-report-nbsp nil))

  (use-package flycheck-ledger
    :defer t
    :ensure t)


  :config
  ;; (setq flycheck-mode-line-prefix "f")

  (setq flycheck-clang-include-path '(
									  "/home/unchartech_5/data-bloomberg/inc/"
									  "/home/unchartech_5/data-bloomberg/inc/blpapi"
									  "/home/unchartech_5/data-bloomberg/inc/utils"
									  "/usr/include/postgresql/"
									  ))


  (setq flycheck-clang-language-standard "-std=c++17")
  ;; (setq flycheck-clang-args '("-std=c++11"))
  (setq flycheck-clang-warnings '("all" "extra" "-D LINUX"))
  ;; (setq flycheck-idle-change-delay 2)
  (setq flycheck-check-syntax-automatically
        '(save
          mode-enabled
          new-line)))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
