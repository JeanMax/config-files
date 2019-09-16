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
;    Updated: 2019/04/22 20:06:58 by mc               ###   ########.fr        ;
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
  (setq flycheck-clang-include-path
        '(
		  "/home/mc/data-bloomberg/bloomberg/bloomberg-utils/inc"
		  "/home/mc/data-bloomberg/bloomberg/datafeed-intraday/inc"
		  "/home/mc/data-bloomberg/bloomberg/datafeed-reference/inc"
		  "/home/mc/data-bloomberg/intraday-dumper/inc"
		  "/home/mc/data-bloomberg/utils/inc"
		  "/home/mc/data-bloomberg/utils/inc/nats"
		  "/home/mc/data-bloomberg/utils/inc/json"
		  "/home/mc/data-bloomberg/extern/inc/"
		  "/home/mc/data-bloomberg/extern/inc/blpapi"
		  ))

  ;; (setq flycheck-clang-include-path
  ;;       '(
  ;; 		  "/home/mc/data-bloomberg/bloomberg/bloomberg-utils/inc"
  ;; 		  "/home/mc/data-bloomberg/bloomberg/datafeed-intraday/inc"
  ;; 		  "/home/mc/data-bloomberg/bloomberg/datafeed-reference/inc"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/blpapi"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/json"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/nats"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/nats/adapters"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/nats/include"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/nats/stan"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/pqxx"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/pqxx/internal"
  ;; 		  "/home/mc/data-bloomberg/extern/inc/pqxx/internal/gates"
  ;; 		  "/home/mc/data-bloomberg/intraday-dumper/inc"
  ;; 		  "/home/mc/data-bloomberg/utils/inc"
  ;; 		  "/home/mc/data-bloomberg/utils/inc/nats"
  ;; 		  ))

  ;; (setq flycheck-clang-include-path
  ;;       '("/tmp/p/includes"
  ;;         "/tmp/p/lib/libft/includes"
  ;; 		  "/tmp/p/lib/option/includes"))


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
