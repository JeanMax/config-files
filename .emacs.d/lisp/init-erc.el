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
;    Updated: 2016/08/27 21:52:10 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(defun ercs ()
  "Connect to some IRC."
  (interactive)
  (when (y-or-n-p "Freenode? ")
    (erc :server "irc.freenode.net" :port 6667 :nick "JeanMax"))
  (when (y-or-n-p "Synirc? ")
    (erc :server "irc.synirc.net" :port 6667 :nick "Smurf")))


(use-package erc
  :defer t

  :config
  (setq erc-save-buffer-on-part t)
  (setq erc-autojoin-channels-alist
        '((".*\\.freenode.net" "#emacs" "#trisquel" "#zboub")
          (".*\\.synirc.net" "#d2bs")))
  (setq erc-keywords '("jean" "smurf"))
  (erc-match-mode)
  (defvar erc-insert-post-hook)
  (add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
  (setq erc-max-buffer-size 20000)  ;; Truncate buffers so they don't hog core. ;;TODO: be sure it still logs
  (setq erc-truncate-buffer-on-save t)
  (setq erc-log-channels-directory "~/.emacs.d/misc/erc-log")
  (setq erc-modules
        '(autojoin button completion fill irccontrols keep-place list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track))
  (setq erc-nick "JeanMax")
  ;; (setq erc-prompt-for-password nil)
  (erc-track-mode)
  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE" "333" "353"))
)


(provide 'init-erc)
;;; init-erc.el ends here
