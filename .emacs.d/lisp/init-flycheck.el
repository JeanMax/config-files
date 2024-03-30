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

  (setq flycheck-clang-include-path
        '(

          "/home/mcanal/aggron/app/qualif_tests/include"
          "/home/mcanal/aggron/app/scesa-common/include"
          "/home/mcanal/aggron/bsw/api"
          "/home/mcanal/aggron/bsw/bazar/include"
          "/home/mcanal/aggron/bsw/drivers"
          "/home/mcanal/aggron/bsw/drivers/cpu/include"
          "/home/mcanal/aggron/bsw/drivers/include"
          "/home/mcanal/aggron/bsw/include"
          "/home/mcanal/aggron/bsw/services/network/lwip-configuration"
          "/home/mcanal/aggron/bsw/services/os/include"
          "/home/mcanal/aggron/bsw/services/safety_mechanisms/interface"
          "/home/mcanal/aggron/build/cgen/ab_encoder_driver.api"
          "/home/mcanal/aggron/build/cgen/can_interfaces.api"
          "/home/mcanal/aggron/build/cgen/can_protocols.api"
          "/home/mcanal/aggron/build/cgen/cmu.api"
          "/home/mcanal/aggron/build/cgen/crc.api"
          "/home/mcanal/aggron/build/cgen/fault_manager.api"
          "/home/mcanal/aggron/build/cgen/flexcan.api"
          "/home/mcanal/aggron/build/cgen/gpio.api"
          "/home/mcanal/aggron/build/cgen/incremental_encoder_sampling.api"
          "/home/mcanal/aggron/build/cgen/intm.api"
          "/home/mcanal/aggron/build/cgen/log.api"
          "/home/mcanal/aggron/build/cgen/pit.api"
          "/home/mcanal/aggron/build/cgen/power_monitoring.api"
          "/home/mcanal/aggron/build/cgen/qualif_tests.app.Qualif-tested"
          "/home/mcanal/aggron/build/cgen/registers_monitoring.api"
          "/home/mcanal/aggron/build/cgen/sar_adc.api"
          "/home/mcanal/aggron/build/cgen/scst_a53.api"
          "/home/mcanal/aggron/build/cgen/sequencer.api"
          "/home/mcanal/aggron/build/cgen/sequencer_monitoring.api"
          "/home/mcanal/aggron/build/cgen/sequencer_statistics.api"
          "/home/mcanal/aggron/build/cgen/siul2.api"
          "/home/mcanal/aggron/build/cgen/swt.api"
          "/home/mcanal/aggron/build/cgen/temperature.api"
          "/home/mcanal/aggron/build/cgen/temperature_monitoring.api"
          "/home/mcanal/aggron/build/cgen/timer.api"
          "/home/mcanal/aggron/build/cgen/tmu.api"
          "/home/mcanal/aggron/build/cgen/watchdog.api"
          "/home/mcanal/aggron/build/ICD/common"
          "/home/mcanal/aggron/build/ICD/logger_default"
          "/home/mcanal/aggron/build/ICD/qualif-ECU"
          "/home/mcanal/aggron/build/ICD/Qualif-tested"
          "/home/mcanal/aggron/build/ICD/S32V"
          "/home/mcanal/aggron/build/ICD/services_default"
          "/home/mcanal/aggron/external/lwip/src/include"
          "/home/mcanal/aggron/external/scst_a53/src/h"
          "/home/mcanal/aggron/lib/libc/include"
          "/home/mcanal/aggron/lib/libc/include/aarch64"
          "/home/mcanal/aggron/lib/libm/include"
          "/home/mcanal/aggron/lib/utils/include"
          "/home/mcanal/aggron/lib/version/include"

          ))


  (setq-default flycheck-python-flake8-executable "flake8")
  (setq-default flycheck-disabled-checkers '(python-pylint python-mypy python-flake8))
  ;; (flycheck-add-next-checker 'python-flake8 'python-pylint)

  (setq flycheck-clang-language-standard "-std=c11")
  (setq flycheck-clang-warnings '("all" "extra" "switch-enum" "float-conversion"  "no-error=deprecated-declarations" "deprecated-declarations" "no-unknown-pragmas" "no-type-limits" "implicit-function-declaration"))  ; "no-unused-parameter" "no-unused-variable"
  (setq flycheck-clang-args '("-ffunction-sections" "-fdata-sections" "-nostdinc" "-nostartfiles" "-nostdlib" "-static"))


  ;; (setq flycheck-clang-definitions '("__linux__" "LINUX" "NDEBUG" ))
  (setq flycheck-clang-definitions '("_GNU_SOURCE" "PB_NO_PACKED_STRUCTS" "PB_BUFFER_ONLY" "PB_FIELD_32BIT"))





  ;; (setq flycheck idle-change-delay 2)
  (setq flycheck-check-syntax-automatically
        '(save
          mode-enabled
          new-line)))

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
