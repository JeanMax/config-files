;;; 42-mode.el --- init ample-theme
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    42-mode.el                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/01/05 14:30:28 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;;;###autoload
(define-minor-mode 42-mode
  "C-mode with tab indentation and 42-school coding standard errors highlighted."
  :lighter " 42"
  ;; :keymap (let ((map (make-sparse-keymap)))
  ;;           (define-key map (kbd "q") '42-mode)

  ;;           map)

  ;; TODO create an highlight shit mode
  ;; (highlight-regexp "\t ")
  ;; (highlight-regexp " \t")
  ;; (highlight-regexp "if(")
  ;; (highlight-regexp "while(")
  ;; (highlight-regexp "return(")
  ;; (highlight-regexp "return;")
  ;; (highlight-regexp "break;")
  ;; (highlight-regexp "continue;")
  ;; (highlight-regexp "\n\n\n+")
  ;; (highlight-lines-matching-regexp ".\\{81\\}" 'hi-red-b)
  ;; (highlight-regexp "{\n\\(.*\n\\)\\{26,\\}}\n\\(\n\\|\\'\\)" 'hi-red-b)
  ;; (highlight-regexp "^[^#/].*[^\"]  +")
  ;; (highlight-regexp "\[([\][[:space:]]")
  ;; (highlight-regexp "[[:space:]]\[])\]")

  ;; indentation fix (struct/switch)
  (c-set-offset 'case-label '+) ; indentation fix (struct/switch)
  (setq indent-tabs-mode t))

;;;###autoload
(add-hook 'c-mode-hook
          '(lambda ()
             (when (string-match "\\.[ch]\\'" (buffer-name))
               (42-mode))))

(provide '42-mode)
;;; 42-mode.el ends here
