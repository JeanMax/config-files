;;; altgr.el --- init altgr
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    altgr.el                                           :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/09/29 14:43:15 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; detect emacsclient/os
(defconst *is-a-server*
  (let ((prev_cmd (getenv "_")))
	(if (eq nil prev_cmd)
		nil
	  (string-equal "emacsclient" (file-name-nondirectory prev_cmd)))))
(defconst *is-a-mac* (eq system-type 'darwin))


  ;; alias for altgr keys, since they change a lot between keyboards
(if *is-a-mac*
    (progn (defconst *altgr-a* "´")
           (defconst *altgr-z* "Â")
           (defconst *altgr-e* "€")
           (defconst *altgr-r* "®")
           (defconst *altgr-t* "†")
           (defconst *altgr-y* "Ú")
           (defconst *altgr-u* "º")
           (defconst *altgr-i* "î")
           (defconst *altgr-o* "œ")
           (defconst *altgr-p* "π")
           (defconst *altgr-q* "´")
           (defconst *altgr-s* "Ò")
           (defconst *altgr-d* "∂")
           (defconst *altgr-f* "ƒ")
           (defconst *altgr-g* "ﬁ")
           (defconst *altgr-h* "Ì")
           (defconst *altgr-j* "Ï")
           (defconst *altgr-k* "È")
           (defconst *altgr-l* "¬")
           (defconst *altgr-m* "µ")
           (defconst *altgr-w* "‹")
           (defconst *altgr-x* "≈")
           (defconst *altgr-c* "©")
           (defconst *altgr-v* "◊")
           (defconst *altgr-b* "ß")
           (defconst *altgr-n* "~")
           (defconst *altgr-$* "¤"))

  ;alternative french?
  ;; (defconst *altgr-a* "æ")
  ;; (defconst *altgr-z* "«")
  ;; (defconst *altgr-e* "€")
  ;; (defconst *altgr-r* "¶")
  ;; (defconst *altgr-t* "ŧ")
  ;; (defconst *altgr-y* "←")
  ;; (defconst *altgr-u* "↓")
  ;; (defconst *altgr-i* "→")
  ;; (defconst *altgr-o* "ø")
  ;; (defconst *altgr-p* "þ")
  ;; (defconst *altgr-q* "@")
  ;; (defconst *altgr-s* "ß")
  ;; (defconst *altgr-d* "ð")
  ;; (defconst *altgr-f* "đ")
  ;; (defconst *altgr-g* "ŋ")
  ;; (defconst *altgr-h* "ħ")
  ;; (defconst *altgr-j* "")
  ;; (defconst *altgr-k* "ĸ")
  ;; (defconst *altgr-l* "ł")
  ;; (defconst *altgr-m* "µ")
  ;; (defconst *altgr-w* "ł")
  ;; (defconst *altgr-x* "»")
  ;; (defconst *altgr-c* "¢")
  ;; (defconst *altgr-v* "“")
  ;; (defconst *altgr-b* "”")
  ;; (defconst *altgr-n* "n")
  ;; (defconst *altgr-$* "¤"))


  ;setxkbmap -layout fr -variant oss -option caps:super
  (defconst *console* "²")
  (defconst *altgr-a* "æ")
  (defconst *altgr-z* "â")
  (defconst *altgr-e* "€")
  (defconst *altgr-r* "ê") ; I use that :/
  (defconst *altgr-t* "þ")
  (defconst *altgr-y* "ÿ")
  (defconst *altgr-u* "û")
  (defconst *altgr-i* "î")
  (defconst *altgr-o* "œ")
  (defconst *altgr-p* "ô")
  (defconst *altgr-q* "ä")
  (defconst *altgr-s* "ß")
  (defconst *altgr-d* "ë")
  (defconst *altgr-f* "‘")
  (defconst *altgr-g* "’")
  (defconst *altgr-h* "ð")
  (defconst *altgr-j* "ü")
  (defconst *altgr-k* "ï")
  (defconst *altgr-l* "ŀ")
  (defconst *altgr-m* "ö")
  (defconst *altgr-w* "«")
  (defconst *altgr-x* "»")
  (defconst *altgr-c* "©")
  (defconst *altgr-v* " ")
  (defconst *altgr-b* "↓")
  (defconst *altgr-n* "¬")
  (defconst *altgr-$* "ø"))
;TODO: add a variable to configure this at runtime


;; TODO: list free 'mod+key', keys (f1..12, weird stuffs: ù²¨^)
;; (bind-key* (kbd *altgr-z*) 'free)
;; (bind-key* (kbd *altgr-y*) 'free)
;; (bind-key* (kbd *altgr-u*) 'free)
;; (bind-key* (kbd *altgr-s*) 'ibuffer-mode)
;; (bind-key* (kbd *altgr-d*) 'free)
;; (bind-key* (kbd *altgr-l*) 'free)
;; (bind-key* (kbd *altgr-w*) 'free)
;; (bind-key* (kbd *altgr-c*) 'free)


(provide 'altgr)
;;; altgr.el ends here
