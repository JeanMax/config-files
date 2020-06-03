;;; init-emms.el --- init emms
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-emms.el                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/10/18 10:45:43 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package emms
  :ensure t
  :defer t

  :init
  (defalias 'radio 'emms-streams)

  :config
  (progn
    ;; (setq emms-directory "~/.emacs.d/misc/emms")
    (emms-standard)
    (emms-default-players)

    (use-package emms-streams
      :defer t

      :init
      (setq emms-stream-default-action "play")
      (dolist (radio '(("One HipHop" "http://listen.one.hiphop/live" 1 url)
                       ("FIP" "http://direct.fipradio.fr/live/fip-midfi.mp3" 1 url)
                       ("RadioJazz - Manouche" "http://jazz-wr02.ice.infomaniak.ch/jazz-wr02-128.mp3" 1 url)
                       ("RadioJazz - Blues" "http://jazzblues.ice.infomaniak.ch/jazzblues-high.mp3" 1 url)
                       ("RadioJazz - Groove" "http://jazz-wr08.ice.infomaniak.ch/jazz-wr08-128.mp3" 1 url)
                       ("RadioJazz - Funk" "http://jazz-wr06.ice.infomaniak.ch/jazz-wr06-128.mp3" 1 url)))
        (add-to-list 'emms-stream-default-list radio)))))


(provide 'init-emms)
;;; init-emms.el ends here
