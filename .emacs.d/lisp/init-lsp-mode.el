;;; init-lsp-mode.el --- init lsp-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-lsp-mode.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    you want with this stuff. If we meet some day, and you     |:: '   :|     ;
;                                                                              ;
;******************************************************************************;



;;; Code:
(setenv "LSP_USE_PLISTS" "true")

(use-package lsp-mode
  :ensure t
  :defer t
  :commands lsp

  :init
  (setq lsp-use-plists t)
  (setq lsp-keymap-prefix "C-c l")

  ;; :hook (
  ;;        (python-mode . lsp)
  ;;        (c-mode . lsp)
  ;;        (c++-mode . lsp)
  ;;        ;; (dockerfile-mode . lsp)
  ;;        ;; ;; (lua-mode . lsp)
  ;;        ;; ;; (yaml-mode . lsp)
  ;;        ;; ;; (json-mode . lsp)
  ;;        ;; ;; (sh-mode . lsp)
  ;;        ;; ;; (groovy-mode . lsp)
  ;;        ;; (lsp-mode . lsp-enable-which-key-integration)
  ;;        )

  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-pylsp-plugins-flake8-enabled nil)
  (setq lsp-pylsp-plugins-mccabe-enabled nil)
  (setq lsp-pylsp-plugins-pycodestyle-enabled nil)
  (setq lsp-pylsp-plugins-pydocstyle-enabled nil)
  (setq lsp-pylsp-plugins-ruff-enabled t)
  (setq lsp-pylsp-plugins-mypy-enabled t)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-keep-workspace-alive nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-enable-snippet nil)
  (add-hook 'lsp-configure-hook (lambda ()
                             (setq xref-backend-functions #'etags--xref-backend))))

;; (require 'lsp-ido)


(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
  ;; :config
  ;; (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-doc-header t)
  ;; (setq lsp-ui-doc-include-signature t)
  ;; (setq lsp-ui-doc-border (face-foreground 'default))
  ;; (setq lsp-ui-sideline-show-code-actions t)
  ;; (setq lsp-ui-sideline-delay 0.05)
  )

(use-package lsp-lens
  :after lsp-mode
  :diminish lsp-lens-mode)

(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)

;; ;; optionally if you want to use debugger
;; (use-package dap-mode)
;; ;; (use-package dap-LANGUAGE) to load the dap adapter for your language



;; optional if you want which-key integration
(use-package which-key
  :ensure t
  ;; :defer t
  :diminish which-key-mode
  :config
  (which-key-mode))


(provide 'init-lsp-mode)
;;; init-lsp-mode.el ends here
