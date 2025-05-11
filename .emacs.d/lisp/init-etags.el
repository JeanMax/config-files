;;; init-etags.el --- init etags
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-etags.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/08/04 16:00:37 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package etags
  :defer t

  :config
  ;; FIXME
  ;; (defvar tags-make-n-visit-history '("--regex='/.*\\(public\\|static\\|abstract\\|protected\\|private\\).*function.*(/' ~/Pliizz/src/**/*.php"))
  (defvar tags-make-n-visit-history '("~/babao/src/babao/**/*.py ~/.local/lib/python*/site-packages/{{krakenex,configparser}*/**/,argparse}*.py"))
  (eval-after-load "savehist"
    '(add-to-list 'savehist-additional-variables 'tags-make-n-visit-history))
  (savehist-mode 1)
  ;; (setq savehist-file "~/.emacs.d/misc/history")
  )


(defun tags-make-n-visit (file-pattern)
  "Create a tag file corresponding to FILE-PATTERN, then visit it."
  (interactive
   (list (read-from-minibuffer
          (concat "tag pattern (default " (nth 0 tags-make-n-visit-history) "): ")
          nil nil nil 'tags-make-n-visit-history)))
  (shell-command (concat "etags -o ~/config-files/.emacs.d/TAGS "
                         (if (string= "" file-pattern)
                             (nth 0 tags-make-n-visit-history)
                           file-pattern)))
  (visit-tags-table "~/config-files/.emacs.d/TAGS"))

;; (setq tags-table-list '("/home/mcanal/.emacs.d/TAGS"))))


(defun find-definition-maybe-lsp-maybe-xref (identifier) ; &key display-action)
  "Use either xref-find-definitions or lsp-find-definitions to find IDENTIFIER."
  (interactive (list (or lsp-mode (xref--read-identifier "Find definitions of: "))))
  (if lsp-mode
      (lsp-find-definition) ; :display-action display-action)
    (xref-find-definitions identifier)))


(require 'altgr)
(bind-key* (kbd *altgr-t*) 'tags-make-n-visit)
(bind-key* (kbd *altgr-g*) 'find-definition-maybe-lsp-maybe-xref)
(bind-key* (kbd *altgr-x*) 'xref-find-references)
;; (bind-key* (kbd *altgr-r*) 'recentf-open-files)

;; need system package "global"
(use-package ggtags
  :ensure t
  :defer t

  :init
  ;; (use-package gtags
  ;;   :ensure t
  ;;   :defer t)
  (add-hook 'c-mode-common-hook
			(lambda ()
			  (when (derived-mode-p 'c-mode 'c++-mode)
				(ggtags-mode 1))))

  :config
  (setq-local hippie-expand-try-functions-list
			  (cons 'ggtags-try-complete-tag hippie-expand-try-functions-list))
  ;; (bind-key* (kbd *altgr-g*) 'ggtags-find-tag-dwim) #TODO
  ;; (bind-key* (kbd *altgr-x*) 'ggtags-find-reference)
  )


(provide 'init-etags)
;;; init-etags.el ends here
