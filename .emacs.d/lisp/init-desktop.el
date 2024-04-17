;;; init-desktop.el --- init desktop
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-desktop.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/03/01 12:16:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(require 'altgr)

(use-package desktop
  :init
  ;; restore session (buffers, desktops...)
  (when *is-a-server*
    (desktop-save-mode 1)
    (setq desktop-save t))

  :config
  ;; (setq desktop-path '("~/.emacs.d/misc/")))
  (setq desktop-buffers-not-to-save
        (concat "\\("
                "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
                "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
                "\\|^\*vc-.*\*$\\|^timemachine:\\|^\*magit"
                "\\|:.*:\\|^\*.*\*$"
                "\\|^\*breakpoints.*\\|^\*locals.*\\|^\*registers.*\\|^\*stack.*\\|^\*threads.*\\|^\*input/output.*"
                "\\)$"))
  ;; (setq desktop-files-not-to-save
  ;;       (concat "\\("
  ;;               "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
  ;;               "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
  ;;               "\\|^\*vc-.*\*$\\|^timemachine:\\|^\*magit"
  ;;               "\\|:.*:\\|^\*.*\*$"
  ;;               "\\|^\*breakpoints.*\\|^\*locals.*\\|^\*registers.*\\|^\*stack.*\\|^\*threads.*\\|^\*input/output.*"
  ;;               "\\)$"))
  (add-to-list 'desktop-modes-not-to-save 'dired-mode)
  (add-to-list 'desktop-modes-not-to-save 'Info-mode)
  (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
  (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
  (add-to-list 'desktop-modes-not-to-save 'gud-mode)
  (add-to-list 'desktop-modes-not-to-save 'message-mode)
  (add-to-list 'desktop-modes-not-to-save 'bbdb-mode)
  (add-to-list 'desktop-modes-not-to-save 'mail-mode)
  (add-to-list 'desktop-modes-not-to-save 'gnus-group-mode)
  (add-to-list 'desktop-modes-not-to-save 'gnus-summary-mode)
  (add-to-list 'desktop-modes-not-to-save 'gnus-article-mode)
  (add-to-list 'desktop-modes-not-to-save 'erc-mode)
  (add-to-list 'desktop-modes-not-to-save 'git-timemachine-mode))


;; TODO: save windows config in register
;; window-configuration-to-register -> jump-to-register
(defun k-thx-bye ()
  "Exit server and save desktop."
  (interactive)
  (kill-matching-buffers "^timemachine:.*")
  (when (y-or-n-p "Save Desktop? ")
	;; (smex-save-to-file)
    (desktop-save "~/.emacs.d"))
  (save-buffers-kill-terminal)
  (kill-emacs))

(provide 'init-desktop)
;;; init-desktop.el ends here
