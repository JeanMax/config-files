;;; init-marginalia.el --- init marginalia
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-marginalia.el                                   :+:      :+:    :+:  ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:08:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;TODO: eval-expression fun completion is chaotic
(use-package marginalia
  :ensure t
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode)
  :config
  (setq marginalia-annotator-registry
        '((command marginalia-annotate-command marginalia-annotate-binding builtin none)
          (embark-keybinding marginalia-annotate-embark-keybinding builtin none)
          (customize-group marginalia-annotate-customize-group builtin none)
          (variable marginalia-annotate-variable builtin none)
          (function marginalia-annotate-function builtin none)
          (face marginalia-annotate-face builtin none)
          (color marginalia-annotate-color builtin none)
          (unicode-name marginalia-annotate-char builtin none)
          (minor-mode marginalia-annotate-minor-mode builtin none)
          (symbol marginalia-annotate-symbol builtin none)
          (environment-variable marginalia-annotate-environment-variable builtin none)
          (input-method marginalia-annotate-input-method builtin none)
          (coding-system marginalia-annotate-coding-system builtin none)
          (charset marginalia-annotate-charset builtin none)
          (package marginalia-annotate-package builtin none)
          (imenu marginalia-annotate-imenu builtin none)
          (bookmark marginalia-annotate-bookmark builtin none)
          (file marginalia-annotate-file builtin none)
          (project-file project--annotate-file builtin none)  ;; I just wanted to edit this...
          (buffer marginalia-annotate-buffer builtin none)
          (library marginalia-annotate-library builtin none)
          (theme marginalia-annotate-theme builtin none)
          (tab marginalia-annotate-tab builtin none)
          (multi-category marginalia-annotate-multi-category builtin none))))

(provide 'init-marginalia)
;;; init-marginalia.el ends here
