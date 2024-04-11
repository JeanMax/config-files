;;; init-simple.el --- init simple
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-simple.el                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/03/25 16:12:24 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package simple
  :config
  ;; limit mouse selection to active window
  ;; TODO; do not move the cursor...
  ;; (xterm-mouse-mode)
  ;; selecting region with shift
  (transient-mark-mode t)

  (bind-key* (kbd "<home>") 'backward-page)
  (bind-key* (kbd "<end>") 'forward-page)

  ;; copy / cut / paste / smurf
  (bind-key* (kbd "<f2>") 'kill-region)
  (bind-key* (kbd "<f3>") 'kill-ring-save)
  (bind-key* (kbd "<f4>") 'yank)
  (bind-key* (kbd "<f5>") 'kill-line)
  (bind-key* (kbd "<f8>") 'undo)
  (bind-key* (kbd "C-x c") 'copy-killring-to-clipboard)

  ;; insert pair
  (bind-key* (kbd "M-&") 'par) ; 1
  (bind-key* (kbd "M-é") 'cro) ; 2
  (bind-key* (kbd "M-\"") 'aco) ; 3
  (bind-key* (kbd "M-\'") 'guigui) ; 4
  (bind-key* (kbd "M-(") 'gui) ; 5
  (bind-key* (kbd "M--") 'inc) ; 6
  ;; insert \n && \t
  (bind-key* (kbd "C-c RET") 'insert-eol)
  (bind-key* (kbd *altgr-a*) 'tab-to-tab-stop)
  (bind-key* (kbd *console*) 'tab-to-tab-stop)

  (defun copy-killring-to-clipboard()
    "Copy killring to clipboard!"
    (interactive)
    (let ((temp-file "/tmp/.clipboard"))
      (with-temp-file temp-file (yank))
      (shell-command (format
                      "xsel --clipboard --input < %s && rm -f %s"
                      temp-file temp-file)))
    (message "Kill-ring copied to clipboard!"))

  (defun par()
    "par"
    (interactive)
    (insert "()")
    (backward-char 1))

  (defun cro()
    "cro"
    (interactive)
    (insert "[]")
    (backward-char 1))

  (defun aco()
    "ac"
    (interactive)
    (move-end-of-line 1)
    (insert " {\n\n}")
    (indent-for-tab-command)
    (previous-line 1)
    (indent-for-tab-command))

  (defun guigui()
    "guigui"
    (interactive)
    (insert "\"\"")
    (backward-char 1))

  (defun gui()
    "gui"
    (interactive)
    (insert "\'\'")
    (backward-char 1))

  (defun inc()
    "inc"
    (interactive)
    (insert "<>")
    (backward-char 1))

  (defun insert-eol ()
    "Insert a pretty \\n !"
    (interactive)
    (insert "\n"))

  (defun comment()
    "comment"
    (interactive)
    (let ((start (line-beginning-position))
          (end (line-end-position)))
      (when (or (not transient-mark-mode) (region-active-p))
        (setq start (save-excursion
                      (goto-char (region-beginning))
                      (beginning-of-line)
                      (point))
              end (save-excursion
                    (goto-char (region-end))
                    (end-of-line)
                    (point))))
      (comment-or-uncomment-region start end)))

  (defun insert-debug-comment()
    "Insert a 'debug' comment."
    (interactive)
    (point-to-register 'm)
    (comment-dwim nil)
    (insert "DEBUG")
    (jump-to-register 'm))

  (defun set-comment-char (char)
    "Set comment CHAR for current buffer."
    (interactive "sComment char: ")
    (setq comment-start char)
    (font-lock-add-keywords
     nil
     `((,(concat comment-start ".+") . font-lock-comment-face)))))


(provide 'init-simple)
;;; init-simple.el ends here
