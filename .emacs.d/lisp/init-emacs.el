;;; init-emacs.el --- init emacs
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-emacs.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/06 00:36:29 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package emacs
  :config
  
  ;; mode line customization (bottom bar)
  (setq-default mode-line-format
				'(
				  ;; full-memory error (never seen that...)
				  "%e"
				  
				  ;; buffer-name + color readonly/modified
				  (:eval (propertize " %b " 'face
									 (cond ((eql buffer-read-only t) ;TODO: what if it's read-only And mofified? (do we even care?!)
											'(:foreground "black" :background "#5180b3" :weight bold))
										   ((buffer-modified-p)
											'(:foreground "black" :background "#df9522" :weight bold))
										   (t
											'(:foreground "black"  :background "#6aaf50" :weight bold)))))

				  ;; line/col number
				  (:propertize "%4l:")
				  (:eval (propertize (format "%-3s" (format-mode-line "%c")) 'face
									 (when (> (current-column) 80)
                                       '(:background "#cd5542"))))

				  ;; are we on emacsclient?
				  (:eval (propertize (when (frame-parameter nil 'client) "@")))

				  ;; percent of buffer
				  "%6p "

				  ;; flycheck errors
				  (:eval (let-alist (flycheck-count-errors flycheck-current-errors)
						   (cond
							((and .error .warning)
							 (propertize (format "%s/%s" .error .warning) 'face '(:foreground "black" :background "#cd5542" :weight bold)))
							(.error
							 (propertize (format "%s" .error) 'face '(:foreground "black" :background "#cd5542" :weight bold)))
							(.warning
							 (propertize (format "%s" .warning) 'face '(:foreground "black" :background "#df9522" :weight bold))))))
				  
				  ;; mail notifications (FIXME: require Inbox open?)
				  (:eval (propertize (let ((got-mail (and (fboundp 'gnus-newsgroup-unreads) gnus-newsgroup-unreads)))
									   (when got-mail
										   (progn " M " 'face '(:foreground "black" :background "#dF9522" :weight bold))))))
				  "  "

				  ;; current directory (TODO: short-short-short?)
				  (:eval (propertize (extra-shorten-directory default-directory) 'face '(:weight bold)))
				  "   "

				  ;; actives modes
				  mode-line-modes))

  ;; enable col number
  (column-number-mode 1))


;; 'truncate-string-to-width works pretty well too...
(defun extra-shorten-directory (dir)
  "MOAR DIR!"
  ;; (shorten-directory
  (replace-regexp-in-string (expand-file-name "~") "~" dir))
;; 30))

;; (defun right-padding (str len)
;;   "Padd a string STR with space to the right (till total length >= LEN)."
;;   (let ((space-len (- len (length str))))
;;     (if (> space-len 0)
;;         (concat str (make-string space-len ? ))
;;       str)))

;; (defun shorten-directory (dir max-length)
;;   "DIR... Show up to MAX-LENGTH characters of a directory name DIR."
;;   (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
;;         (output ""))
;;     (when (and path (equal "" (car path)))
;;       (setq path (cdr path)))
;;     (while (and path (< (length output) (- max-length 4)))
;;       (setq output (concat (car path) "/" output))
;;       (setq path (cdr path)))
;;     (when path
;;       (setq output (concat ".../" output)))
;;     output))



(provide 'init-emacs)
;;; init-emacs.el ends here
