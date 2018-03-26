;;; init-ruby-mode.el --- init ruby-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ruby-mode.el                                     :+:      :+:    :+: ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/03/26 13:31:06 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package ruby-mode
  :defer t
  :mode
   ;; ("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode)
  ("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode)

  :config
  (define-key ruby-mode-map (kbd "C-c C-c") 'ruby-send-buffer)
  (define-key ruby-mode-map (kbd "C-c C-r") 'ruby-send-region)
  (setq ruby-indent-level 4)

  (use-package inf-ruby
	:ensure t
	:init
	(setq inf-ruby-default-implementation "pry")))

(provide 'init-ruby-mode)
;;; init-ruby-mode.el ends here
