;;; init-diff.el --- init diff
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-vc-dir.el                                  :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/09/10 12:59:44 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package vc-dir
  :defer t

  :init
  (setq vc-follow-symlinks t)
  ;; (when *is-a-server*
    ;; (ignore-errors (vc-dir default-directory)))

  :config
  (local-set-key (kbd "f") 'vc-dir-find-files))

(bind-key* (kbd "M-v") 'vc-dir)

(defun vc-dir-find-files (&optional arg)
  "Open each of the marked files, or the file under the point,
or when prefix ARG, the next N files."
  (interactive "P")
  (let* ((fn-list (vc-dir-marked-files)))
    (mapc 'find-file fn-list)))


(provide 'init-vc-dir)
;;; init-vc-dir.el ends here
