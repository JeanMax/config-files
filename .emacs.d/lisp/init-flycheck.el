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
;    Updated: 2019/09/16 12:07:56 by mc               ###   ########.fr        ;
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

  (setq-default flycheck-disabled-checkers '(python-pylint python-mypy python-flake8))

  ;; (setq flycheck-clang-language-standard "-std=c11")
  ;; (setq flycheck-clang-warnings '("all" "extra" "switch-enum" "float-conversion"  "no-error=deprecated-declarations" "deprecated-declarations" "no-unknown-pragmas" "no-type-limits" "implicit-function-declaration"))  ; "no-unused-parameter" "no-unused-variable"
  ;; (setq flycheck-clang-args '("-ffunction-sections" "-fdata-sections" "-nostdinc" "-nostartfiles" "-nostdlib" "-static"))


  ;; (setq flycheck-clang-definitions '("__linux__" "LINUX" "NDEBUG" ))
  ;; (setq flycheck-clang-definitions '("_GNU_SOURCE" "PB_NO_PACKED_STRUCTS" "PB_BUFFER_ONLY" "PB_FIELD_32BIT"))


  ;; (setq flycheck idle-change-delay 2)
  (setq flycheck-check-syntax-automatically
        '(save
          mode-enabled
          new-line)))


;; lsp is enough?
;; (use-package flycheck-clang-tidy
;;   :ensure t
;;   :defer t
;;   :after flycheck
;;   :hook (flycheck-mode . flycheck-clang-tidy-setup))


(defun update-include-path (path)
  "Update flycheck clang include PATH."
  (interactive "DPath? ")
  (let ((includes (shell-command-to-string
                   (concat " find "
                           path
                           ;; " /usr/include "
                           " -regex '.*\\.\\(h\\|hpp\\)' "
                           " | xargs dirname | sort | uniq "))))
    (message includes)
    (setq flycheck-clang-include-path (split-string (concat
                                                     "/home/mcanal/aggron/external/lwip/src/include"
                                                     includes)))))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
