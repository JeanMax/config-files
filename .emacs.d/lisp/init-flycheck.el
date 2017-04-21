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
;    Updated: 2017/04/09 12:52:30 by mc               ###   ########.fr        ;
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
        ;; '("/home/mcanal/Shared/motoko/build"
        ;;   "/home/mcanal/Shared/motoko/src"
        ;;   "/home/mcanal/Shared/motoko/src/data"
        ;;   "/home/mcanal/Shared/motoko/lib/util/include"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_pathing"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_chest"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_chicken"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_pickit"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_pes"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_meph"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_dclone"
        ;;   "/home/mcanal/Shared/motoko/lib/plugins/d2gs_record/replay"))

        '("/home/mc/quarantedeux/wolf3d/inc"
		  "/home/mc/quarantedeux/wolf3d/test/inc"
          "/home/mc/quarantedeux/wolf3d/libft/inc"
		  "/home/mc/quarantedeux/wolf3d/libft/test/inc"
		  "/home/mc/quarantedeux/wolf3d/libft/test/minunit"
          "/home/mc/quarantedeux/wolf3d/SDL/include"))
  (setq flycheck-clang-warnings
        '("all" "extra"))
  ;; (setq flycheck-idle-change-delay 2)
  (setq flycheck-clang-args nil)
  (setq flycheck-check-syntax-automatically
        '(save
          mode-enabled
          new-line)))


(provide 'init-flycheck)
;;; init-flycheck.el ends here
