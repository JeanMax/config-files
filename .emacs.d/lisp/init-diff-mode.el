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
;    Updated: 2016/09/13 21:45:56 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package diff-mode
  :defer t
  
  :config
  (defadvice kill-new (before strip-leading-diff-chars activate)
    "When copying from a diff buffer, strip the leading -, +, ! characters."
    (if (eq major-mode 'diff-mode)
        (ad-set-arg 0 (replace-regexp-in-string "^." "" (ad-get-arg 0))))))


(provide 'init-diff-mode)
;;; init-diff-mode.el ends here
