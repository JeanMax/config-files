;;; init-cython-mode.el --- init cython-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-cython-mode.el                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/08/05 04:34:55 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package cython-mode
  :ensure t
  :mode
  ("\\.pyx\\'" . cython-mode)

  :config
  ;; free that for dabbrev-expand
  (define-key python-mode-map (kbd "<backtab>") nil)

  :init
  (progn
	(use-package flycheck-cython
	  :ensure t

	  :init
	  (add-hook 'cython-mode-hook 'flycheck-mode))))

(provide 'init-cython-mode)
;;; init-cython-mode.el ends here
