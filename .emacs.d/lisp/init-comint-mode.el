;;; init-comint-mode.el --- init comint-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-comint-mode.el                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/06/08 12:05:37 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package comint
  :defer t

  :init
  (setq gdb-many-windows t)
  (setq gdb-show-threads-by-default t)

  ;; :config
  (add-hook 'comint-mode-hook
            '(lambda ()
               (define-key comint-mode-map (kbd "C-c r") 'comint-history-isearch-backward))))


;; TODO: move that to compile-mode

(defun endless/send-input (input &optional nl)
  "Send INPUT to the current process.
Interactively also sends a terminating newline."
  (interactive "MInput: \nd")
  (let ((string (concat input (if nl "\n"))))
    ;; This is just for visual feedback.
    (let ((inhibit-read-only t))
      (insert-before-markers string))
    ;; This is the important part.
    (process-send-string
     (get-buffer-process (current-buffer))
     string)))

(defun endless/send-self ()
  "Send the pressed key to the current process."
  (interactive)
  (endless/send-input
   (apply #'string
          (append (this-command-keys-vector) nil))))

;; (dolist (key '("\C-d" "\C-j" "y" "n"))
;;   (define-key compilation-mode-map key
;;     #'endless/send-self))


(provide 'init-comint-mode)
;;; init-comint-mode.el ends here
