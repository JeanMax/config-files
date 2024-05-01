;;; init-orderless.el --- init orderless
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-orderless.el                                    :+:      :+:    :+:  ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:08:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package orderless
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)

  (setq completion-styles '(orderless basic))

   ;; For example, project-find-file uses 'project-files which uses
   ;; substring completion by default. Set to nil to make sure it's using
   ;; flx.
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil)

  ;; (setq completion-category-overrides '((file (styles partial-completion))))
  (setq orderless-matching-styles '(orderless-literal
                                    ;; orderless-prefixes
                                    ;; orderless-initialism
                                    orderless-regexp
                                    ;; orderless-flex
                                    ))

  ;; Use backslash for literal space
  (setq orderless-component-separator 'orderless-escapable-split-on-space))

  )


(provide 'init-orderless)
;;; init-orderless.el ends here
