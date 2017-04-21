;;; init-eww-mode.el --- init eww-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-eww-mode.el                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/04/21 16:46:59 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package eww-mode
  :defer t
  :defines eww-search-prefix

  :config
  (progn
	(setq eww-bookmarks-directory "~/.emacs.d/misc")
    (setq eww-search-prefix
          "https://www.startpage.com/do/dsearch?cat=web&pl=opensearch&language=english&query=")

    (use-package url
      :config
      (setq url-configuration-directory  "~/.emacs.d/misc/url/")
      (setq url-cookie-file "~/.emacs.d/misc/url/cookies"))))


(provide 'init-eww-mode)
;;; init-eww-mode.el ends here
