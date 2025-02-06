;;; init-dumb-jump.el --- init dumb-jump
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-dumb-jump.el                                  :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    you want with this stuff. If we meet some day, and you     |:: '   :|     ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package dumb-jump
  ;; :defer t
  :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))


;; (setq dumb-jump-default-project "~/code")
;; to change default project if one is not found (defaults to ~)

;; (setq dumb-jump-quiet t)
;; if Dumb Jump is too chatty.

;; To support more languages and/or definition types customize
;; dumb-jump-find-rules variable.

;; (setq dumb-jump-force-searcher 'rg)
;; to force the search program Dumb Jump should use. It will always use this searcher. If not set (nil) Dumb Jump will use git-grep if it's a git project and if not will try searchers in the following order ag, rg, grep (first installed wins). This is necessary if you want full control over the searcher Dumb Jump uses.

;; (setq dumb-jump-prefer-searcher 'rg)
;; to let Dumb Jump know your searcher preference. If set this will still use git-grep if it's a git project (because it's the fastest), but will you use whatever you set here in any other situation. If not set Dumb Jump will follow the same order as mentioned in the dumb-jump-force-searcher description. At this time setting this value is only necessary if you prefer rg but have ag installed too.

;; (setq dumb-jump-git-grep-search-args "")
;; to set additional command line arguments when using git-grep for searching (defaults to "").

;; (setq dumb-jump-ag-search-args "")
;; to set additional command line arguments when using ag for searching (defaults to "").

;; (setq dumb-jump-rg-search-args "")
;; to set additional command line arguments when using rg for searching (defaults to "--pcre2").


(provide 'init-dumb-jump)
;;; init-dumb-jump.el ends here
