;;; init-erc.el --- init erc
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-erc.el                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    Updated: 2018/01/23 12:45:56 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(defun ercs ()
  "Connect to some IRC."
  (interactive)
  (when (y-or-n-p "Freenode? ")
    (erc :server "irc.freenode.net" :port 6667 :nick "JeanMax" :password "password"))
  (when (y-or-n-p "Synirc? ")
    (erc :server "irc.synirc.net" :port 6667 :nick "JeanMax")))


(use-package erc
  :defer t

  :config
  (setq erc-save-buffer-on-part t)
  (setq erc-autojoin-channels-alist
        '((".*\\.freenode.net" "#emacs" "#archlinux" "#trisquel" "#zboub" "#ocaml" "#ocsigen" "#tezos")
          (".*\\.synirc.net" "#d2bs")))
  (setq erc-keywords '("jean" "smurf"))
  (erc-match-mode)
  (defvar erc-insert-post-hook)
  (add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
  ;; (setq erc-max-buffer-size 20000)  ;; Truncate buffers so they don't hog core. ;;TODO: be sure it still logs
  ;; (setq erc-truncate-buffer-on-save t)
  ;; (setq erc-log-channels-directory "~/.emacs.d/misc/erc-log")
  (setq erc-modules
        '(autojoin button completion fill irccontrols keep-place list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track))
  (setq erc-nick "JeanMax")
  ;; (setq erc-prompt-for-password nil)
  (erc-track-mode)
  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                  "324" "329" "332" "333" "353" "477"))
  ;; (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK")) ;hide them (not related to tracking)

  (set-face-attribute 'erc-input-face nil :foreground "#cd5542")
  (set-face-attribute 'erc-notice-face nil :foreground "#757575")
  (set-face-attribute 'erc-keyword-face nil :background "#6aaf50"))


(provide 'init-erc)
;;; init-erc.el ends here
