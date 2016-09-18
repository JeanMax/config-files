;;; init-keyfreq.el --- init keyfreq
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-keyfreq.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/10 13:52:22 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package keyfreq
  :ensure t
  :defer t
  :diminish keyfreq-mode
  :defines *is-a-server*

  :config
  (when *is-a-server*
	(keyfreq-mode 1))
  (keyfreq-autosave-mode 1)
  (setq keyfreq-file "~/.emacs.d/misc/keyfreq"))

(provide 'init-keyfreq)
;;; init-keyfreq.el ends here
