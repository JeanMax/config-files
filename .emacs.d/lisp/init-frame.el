;;; init-frame.el --- init frame
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-frame.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/03/04 16:21:57 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package frame
  :config
  ;; line wrap
  (setq-default fill-column 80)
  (setq-default truncate-partial-width-windows 40)

  ;; window splitting at launch
  (setq split-height-threshold 40)
  (setq split-width-threshold 25)
  ;; (setq window-min-height 15)
  ;; (setq window-min-width 15)

  ;; windows configuration history (undo/redo)
  (winner-mode 1))

(bind-key (kbd "M-I") 'enlarge-window)
(bind-key (kbd "M-K") 'shrink-window)
(bind-key (kbd "M-L") 'enlarge-window-horizontally)
(bind-key (kbd "M-J") 'shrink-window-horizontally)
(bind-key (kbd "M-U") 'shrink-window-if-larger-than-buffer)

(bind-key* (kbd "C-x ²") 'delete-window)
(bind-key* (kbd "C-x à") 'delete-window)
(bind-key* (kbd "C-x &") 'delete-other-windows)

(defun split-below-open-previous-buffer()
  "Split horizontally and get previous buffer."
  (interactive)
  (split-window-vertically)
  (other-window 1)
  (mode-line-other-buffer))
(bind-key* (kbd "C-x 2") 'split-below-open-previous-buffer)
(bind-key* (kbd "C-x é") 'split-below-open-previous-buffer)

(defun split-right-open-previous-buffer()
  "Split vertically and get previous buffer."
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  (mode-line-other-buffer))
(bind-key* (kbd "C-x 3") 'split-right-open-previous-buffer)
(bind-key* (kbd "C-x \"") 'split-right-open-previous-buffer)

(defun split-window-4()
  "Splite window into 4 sub-window and get previous buffers."
  (interactive)
  (split-right-open-previous-buffer)
  (split-below-open-previous-buffer)
  (other-window -2)
  (split-below-open-previous-buffer)
  (other-window -1))
(bind-key* (kbd "C-x 4") 'split-window-4)
(bind-key* (kbd "C-x '") 'split-window-4)

(defun toggle-window-split ()
  "Toggle vertical/horizontal splitting."
  (interactive)
  ;; (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1)))))
;; )
(bind-key* (kbd "C-x 5") 'toggle-window-split)
(bind-key* (kbd "C-x (") 'toggle-window-split)




;; windows handling
(cond
 ((version< emacs-version "23")
  (bind-key* (kbd "<A-prior>") (lambda () (interactive) (other-window -1)))
  (bind-key* (kbd "<A-next>") 'other-window)
  (bind-key* (kbd "<A-insert>") 'find-file-other-window)
  (bind-key* (kbd "<A-delete>") 'delete-window))
 (t
  (bind-key* (kbd "ESC <prior>") (lambda () (interactive) (other-window -1)))
  (bind-key* (kbd "ESC <next>") 'other-window)
  (bind-key* (kbd "ESC <insertchar>") 'find-file-other-window)
  (bind-key* (kbd "ESC <deletechar>") 'delete-window)

  ;;we keep this too for gui-macs
  (bind-key* (kbd "<M-prior>") (lambda () (interactive) (other-window -1)))
  (bind-key* (kbd "<M-next>") 'other-window)
  (bind-key* (kbd "<M-insert>") 'find-file-other-window)
  (bind-key* (kbd "<M-delete>") 'delete-window)))


;; buffers handling
(require 'altgr)
(bind-key* (kbd *altgr-k*) 'kill-buffer)
(bind-key* (kbd *altgr-p*) 'mode-line-other-buffer)
(bind-key* (kbd "<f11>") 'save-buffer)
(bind-key* (kbd "<f12>") 'save-buffers-kill-terminal)
(bind-key* (kbd "C-x f") 'find-file)
(bind-key* (kbd *altgr-f*) 'find-file)
(bind-key* (kbd "C-x C-f") 'find-file-other-window)
(bind-key* (kbd *altgr-b*) 'switch-to-buffer)



(provide 'init-frame)
;;; init-frame.el ends here
