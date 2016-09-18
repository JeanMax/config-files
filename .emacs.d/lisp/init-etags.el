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
;    Updated: 2016/09/17 20:22:36 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package etags
  :defer t

  :config
  ;; FIXME
  (defvar tags-make-n-visit-history '("--regex='/.*\\(public\\|static\\|abstract\\|protected\\|private\\).*function.*(/' ~/Pliizz/src/**/*.php"))
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


(bind-key* (kbd "ŧ") 'tags-make-n-visit) ;Altgr t -> elisp-functions.el
(bind-key* (kbd "ŋ") 'xref-find-definitions) ;Altgr g
(bind-key* (kbd "¶") 'recentf-open-files) ;Altgr r

(provide 'init-etags)
;;; init-etags.el ends here
