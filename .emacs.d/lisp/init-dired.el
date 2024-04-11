;;; init-dired.el --- init dired
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-dired.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/01/29 16:51:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package dired
  :defer t

  :config
  (set-face-attribute 'dired-directory nil :foreground ample/blue)
  (set-face-attribute 'dired-symlink nil :foreground ample/green)

  (defun dired-find-files (&optional arg)
    "Open each of the marked files, or the file under the point,
or when prefix ARG, the next Nfiles."
    (interactive "P")
    (let* ((fn-list (dired-get-marked-files nil arg)))
      (mapc 'find-file fn-list)))
  (local-set-key (kbd "f") 'dired-find-files))


;; TODO: rebind / remove these: find room for consult search (maybe remove M-s shell?)
(bind-key (kbd "C-f") 'find-grep-dired)
(bind-key (kbd "M-f") 'find-name-dired)


(provide 'init-dired)
;;; init-dired.el ends here
