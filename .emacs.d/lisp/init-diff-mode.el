;;; init-diff.el --- init diff
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-diff-mode.el                                  :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/06/12 11:29:37 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package diff-mode
  :defer t

  :config
  (defadvice kill-new (before strip-leading-diff-chars activate)
    "When copying from a diff buffer, strip the leading -, +, ! characters."
    (if (or
		 (eq major-mode 'diff-mode)
		 (eq major-mode 'magit-revision-mode))
        (ad-set-arg 0 (replace-regexp-in-string "^." "" (ad-get-arg 0))))))

(use-package ediff
  :defer t

  :init
  (defun ediff-copy-both-to-C ()
    (interactive)
    (ediff-copy-diff ediff-current-difference nil 'C nil
                     (concat
                      (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                      (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))

  (add-hook 'ediff-keymap-setup-hook
            #'(lambda ()
               (define-key ediff-mode-map (kbd "c") 'ediff-copy-both-to-C))))


(provide 'init-diff-mode)
;;; init-diff-mode.el ends here
