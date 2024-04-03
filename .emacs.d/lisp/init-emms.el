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


  :config
  ;; (setq emms-directory "~/.emacs.d/misc/emms")
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "~/Music/")
  (setq emms-player-list '(emms-player-vlc emms-player-vlc-playlist))
  (require 'emms-info-mp3info)
  (add-to-list 'emms-info-functions 'emms-info-mp3info))


(defalias 'radio 'emms-streams)
;; the radio list is located at ~/.emacs.d/emms/streams.emms
;; don't forget to save it!

(use-package emms-streams
  ;; :defer t

  :config
  (setq emms-stream-default-action "play"))


(provide 'init-emms)
;;; init-emms.el ends here
