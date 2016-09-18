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
;    Updated: 2016/09/10 23:33:41 by mcanal           ###   ########.fr        ;
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
    (setq emms-directory "~/.emacs.d/misc/emms")
    (emms-standard)
    (emms-default-players)

    (use-package emms-streams
      :defer t

      :config
      (setq emms-stream-default-action "play")
      (dolist (radio '(("FIP" "http://direct.fipradio.fr/live/fip-midfi.mp3" 1 url)
                       ("RadioJazz - Manouche" "http://jazz-wr02.ice.infomaniak.ch/jazz-wr02-128.mp3" 1 url)
                       ("RadioJazz - Blues" "http://jazzblues.ice.infomaniak.ch/jazzblues-high.mp3" 1 url)
                       ("RadioJazz - Groove" "http://jazz-wr08.ice.infomaniak.ch/jazz-wr08-128.mp3" 1 url)
                       ("RadioJazz - Funk" "http://jazz-wr06.ice.infomaniak.ch/jazz-wr06-128.mp3" 1 url)))
        (add-to-list 'emms-stream-default-list radio)))))


(provide 'init-emms)
;;; init-emms.el ends here
