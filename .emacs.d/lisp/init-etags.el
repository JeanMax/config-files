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
;    Updated: 2017/03/12 19:50:48 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package etags
  :defer t

  :config
  ;; FIXME
  ;; (defvar tags-make-n-visit-history '("--regex='/.*\\(public\\|static\\|abstract\\|protected\\|private\\).*function.*(/' ~/Pliizz/src/**/*.php"))
  (defvar tags-make-n-visit-history '("~/quarantedeux/corewar/**/*.[ch]"))
  (eval-after-load "savehist"
    '(add-to-list 'savehist-additional-variables 'tags-make-n-visit-history))
  (savehist-mode 1)
  (setq savehist-file "~/.emacs.d/misc/history"))


(defun tags-make-n-visit (file-pattern)
  "Create a tag file corresponding to FILE-PATTERN, then visit it."
  (interactive
   (list (read-from-minibuffer
          (concat "tag pattern (default " (nth 0 tags-make-n-visit-history) "): ")
          nil nil nil 'tags-make-n-visit-history)))
  (shell-command (concat "etags -o ~/.emacs.d/misc/TAGS "
                         (if (string= "" file-pattern)
                             (nth 0 tags-make-n-visit-history)
                           file-pattern)))
  (visit-tags-table "~/.emacs.d/misc/TAGS"))


(bind-key* (kbd *altgr-t*) 'tags-make-n-visit)
(bind-key* (kbd *altgr-g*) 'xref-find-definitions)

(provide 'init-etags)
;;; init-etags.el ends here
