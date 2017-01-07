;;; init-markdown-mode.el --- init markdown-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-markdown-mode.el                              :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/11/15 10:25:15 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ;; ("[A-Z]\\+\\'" . gfm-mode)
         ("\\.markdown\\'" . markdown-mode))

  :init
  (setq markdown-command "multimarkdown"))

(provide 'init-markdown-mode)
;;; init-markdown-mode.el ends here
