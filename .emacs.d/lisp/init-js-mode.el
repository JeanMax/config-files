;;; init-js-mode.el --- init js-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-js-mode.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2020/04/05 00:07:55 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package js2-mode
  :defer t
  :ensure t

  :mode
  ("\\.js\\'" . js2-mode)
  ("\\.dbl\\'" . js2-mode)
  ("\\.dbj\\'" . js2-mode)

  :config
  (setq js-indent-level 4)
  ;; (setq tab-width 2) ; or any other preferred value
  (defvaralias 'c-basic-offset 'tab-width)
  (defvaralias 'cperl-indent-level 'tab-width))


(use-package json-mode
  :defer t
  :ensure t

  :mode
  ("\\.json\\'" . json-mode))


(use-package rjsx-mode
  :defer t
  :ensure t

  :mode
  ("\\.jsx\\'" . rjsx-mode))



(provide 'init-js-mode)
;;; init-js-mode.el ends here
