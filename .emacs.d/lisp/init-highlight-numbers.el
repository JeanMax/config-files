;;; init-highlight-numbers.el --- init highlight-numbers
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-highlight-numbers.el                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/18 17:33:43 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package highlight-numbers
  :ensure t
  :commands (highlight-numbers-mode)

  :init
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

(provide 'init-highlight-numbers)
;;; init-highlight-numbers.el ends here
