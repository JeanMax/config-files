;;; move-mode.el --- move-mode!
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    move-mode.el                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/07/20 14:31:29 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(define-minor-mode move-mode
  "Easy move!"
  :lighter " \\o/"
  ;; :global t
  :keymap (let ((map (make-sparse-keymap)))

            (define-key map (kbd "i") 'previous-line)
            (define-key map (kbd "j") 'left-char)
            (define-key map (kbd "k") 'next-line)
            (define-key map (kbd "l") 'right-char)

            (define-key map (kbd "u") 'left-word)
            (define-key map (kbd "o") 'right-word)
            (define-key map (kbd "m") 'normdown) ; -> elisp-functions.el
            (define-key map (kbd "p") 'normup) ; -> elisp-functions.el
            (define-key map (kbd "_") 'move-beginning-of-line) ; 8
            (define-key map (kbd "ç") 'move-end-of-line) ; 9

            (define-key map (kbd "x") 'kill-region)
            (define-key map (kbd "c") 'kill-ring-save)
            (define-key map (kbd "v") 'yank)
            (define-key map (kbd "V") 'yank-pop)

            (define-key map (kbd "g") 'goto-line)
            (define-key map (kbd "z") 'undo)
            (define-key map (kbd "s") 'save-buffer)
            (define-key map (kbd "SPC") 'set-mark-command)

            (define-key map (kbd "b") 'mode-line-other-buffer)
            (define-key map (kbd "y") 'previous-multiframe-window)
            (define-key map (kbd "h") 'next-multiframe-window)
            (define-key map (kbd "d") 'delete-window)

            (define-key map (kbd "q") 'move-mode)
            (define-key map (kbd "w") 'smex)


            map)
  (message "Zboub!"))




(provide 'move-mode)
;;; move-mode.el ends here
