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
;    Updated: 2016/09/10 15:29:08 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package eww-mode
  :defer t
  :defines eww-search-prefix

  :config
  (progn
	(setq eww-search-prefix
		  "https://www.startpage.com/do/dsearch?cat=web&pl=opensearch&language=english&query=")

	(use-package url
	  :config
	  (setq url-configuration-directory  "~/.emacs.d/misc/url/")
	  (setq url-cookie-file "~/.emacs.d/misc/url/cookies"))))


(provide 'init-eww-mode)
;;; init-eww-mode.el ends here
