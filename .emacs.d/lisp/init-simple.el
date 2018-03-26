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
;    Updated: 2018/02/12 13:00:27 by mcanal           ###   ########.fr        ;
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
  ;;(bind-key* (kbd *console*) 'tab-to-tab-stop)
  )

(defun xah-toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Always cycle in this order: ALL CAPS, all lower.

URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2016-01-08"

  ;; TODO:
  ;; if end of word     toggle word's caps (check case of previous char)
  ;; else               toggle char at cursor caps
  (interactive)
  (let (
        (deactivate-mark nil)
        -p1 -p2)
    (if (use-region-p)
        (setq -p1 (region-beginning)
              -p2 (region-end))
      (save-excursion
        (skip-chars-backward "[:alnum:]")
        (setq -p1 (point))
        (skip-chars-forward "[:alnum:]")
        (setq -p2 (point))))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-region -p1 -p2)
      (put this-command 'state 1))
     ((equal 1 (get this-command 'state))
      (downcase-region -p1 -p2)
      (put this-command 'state 0)))))

(defun copy-killring-to-clipboard()
  "Copy killring to clipboard!"
  (interactive)
  (shell-command (concat "xsel -ib << EOF \n" (car kill-ring)))
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
  (insert "\n{")
  (indent-for-tab-command)
  (insert "\n\n}")
  (indent-for-tab-command)
  ;;    (previous-line 1)
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
   `((,(concat comment-start ".+") . font-lock-comment-face))))

(provide 'init-simple)
;;; init-simple.el ends here
