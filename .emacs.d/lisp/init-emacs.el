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
;    Updated: 2016/10/02 16:32:34 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package emacs
  :config

  ;; alias for altgr keys, since they change a lot between keyboards
  (if *is-a-mac*
      (progn (defconst *altgr-a* "´")
             (defconst *altgr-z* "Â")
             (defconst *altgr-e* "€")
             (defconst *altgr-r* "®")
             (defconst *altgr-t* "†")
             (defconst *altgr-y* "Ú")
             (defconst *altgr-u* "º")
             (defconst *altgr-i* "î")
             (defconst *altgr-o* "œ")
             (defconst *altgr-p* "π")
             (defconst *altgr-q* "´")
             (defconst *altgr-s* "Ò")
             (defconst *altgr-d* "∂")
             (defconst *altgr-f* "ƒ")
             (defconst *altgr-g* "ﬁ")
             (defconst *altgr-h* "Ì")
             (defconst *altgr-j* "Ï")
             (defconst *altgr-k* "È")
             (defconst *altgr-l* "¬")
             (defconst *altgr-m* "µ")
             (defconst *altgr-w* "‹")
             (defconst *altgr-x* "≈")
             (defconst *altgr-c* "©")
             (defconst *altgr-v* "◊")
             (defconst *altgr-b* "ß")
             (defconst *altgr-n* "~")
             (defconst *altgr-$* "¤"))

    (defconst *altgr-a* "æ")
    (defconst *altgr-z* "«")
    (defconst *altgr-e* "") ;TODO
    (defconst *altgr-r* "¶")
    (defconst *altgr-t* "ŧ")
    (defconst *altgr-y* "←")
    (defconst *altgr-u* "↓")
    (defconst *altgr-i* "→")
    (defconst *altgr-o* "ø")
    (defconst *altgr-p* "þ")
    (defconst *altgr-q* "") ;TODO
    (defconst *altgr-s* "ß")
    (defconst *altgr-d* "ð")
    (defconst *altgr-f* "đ")
    (defconst *altgr-g* "ŋ")
    (defconst *altgr-h* "ħ")
    (defconst *altgr-j* "") ;TODO
    (defconst *altgr-k* "ĸ")
    (defconst *altgr-l* "ł")
    (defconst *altgr-m* "µ")
    (defconst *altgr-w* "ł")
    (defconst *altgr-x* "»")
    (defconst *altgr-c* "¢")
    (defconst *altgr-v* "“")
    (defconst *altgr-b* "”")
    (defconst *altgr-n* "") ;TODO
    (defconst *altgr-$* "¤"))


  ;; tell emacs where to read abbrev
  (setq save-abbrevs 'silently)
  (setq abbrev-file-name "~/.emacs.d/misc/abbrev_defs")

  ;; eshell
  (setq eshell-directory-name "~/.emacs.d/misc/eshell")

  ;; encoding
  (set-language-environment "UTF-8")

  ;; indentation
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil) ; set to true later for 42-mode
  (setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
  (setq fill-column 80)

  ;; disable top menu bar
  (menu-bar-mode -1)

  ;; splash screen on old versions...
  (setq inhibit-splash-screen t)

  ;; format line number (fringe)
  (setq linum-format "%3d ")

  ;; Ignore case when completing file/buffer names
  (setq read-file-name-completion-ignore-case 't)
  (setq read-buffer-completion-ignore-case 't)

  ;; Increase number of undo
  (setq undo-limit 100000)

  ;; TODO: move to prog-mode?
  (add-hook 'write-file-functions 'delete-trailing-whitespace)

  ;; no problem
  (setq large-file-warning-threshold nil)


  ;; backup (files.el ... TODO: use-package?)
  (setq backup-directory-alist `((".*" . ,"~/.emacs.d/backup")))
  (setq delete-old-versions 42) ;never delete or ask stuff about deleting my precious backups!
  (setq kept-new-versions 42)
  (setq version-control t)
  (setq auto-save-list-file-prefix "~/.emacs.d/misc/auto-save-list/.saves-")
  (setq auto-save-file-name-transforms `((".*" ,"~/.emacs.d/backup" t)))

  ;; bookmark
  (when *is-a-server*
    (bookmark-bmenu-list))
  (setq bookmark-file "~/.emacs.d/misc/bookmarks")
  ;; (bookmark-set)
  ;; (bookmark-jump)
  ;; (list-bookmarks)



  (defalias 'yes-or-no-p 'y-or-n-p)

  ;; del key workaround
  (global-set-key (kbd "DEL") 'backward-delete-char)
  (setq-default c-backspace-function 'backward-delete-char)

  ;; mouse scrolling workaround
  (bind-key* (kbd "<mouse-4>") 'previous-line)
  (bind-key* (kbd "<mouse-5>") 'next-line)

  ;; linum
  (cond
   ((version< emacs-version "23")
    (bind-key* (kbd "<A-up>") 'linum-mode))
   (*is-a-mac*
    (bind-key* (kbd "ESC <up>") 'linum-mode))
   (t
    (bind-key* (kbd "<M-up>") 'linum-mode)))

  ;; search and replace
  (bind-key* (kbd "<f10>") 'query-replace)
  ;; (bind-key* (kbd "C-r") 'rgrep)
  (bind-key* (kbd "C-r") 'isearch-backward)
  (bind-key* (kbd "M-r") 'query-replace-regexp)
  (bind-key* (kbd "C-o") 'occur)

  ;; completion
  (bind-key (kbd "<backtab>") 'dabbrev-expand)
  ;; (bind-key* (kbd *altgr-f*) 'hippie-expand)

  ;; registers
  (bind-key* (kbd "<f7>") 'point-to-register)
  (bind-key* (kbd "<f9>") 'jump-to-register)
  ;; (bind-key* (kbd *altrg-m*) 'point-to-register)

  ;; misc
  (bind-key* (kbd "M-s") 'shell)
  (bind-key* (kbd "M-c") 'compile)
  (bind-key* (kbd "M-q") 'comment) ; -> elisp-functions.el
  (bind-key* (kbd "C-q") 'insert-debug-comment) ; -> elisp-functions.el




  ;; (define-prefix-command '2-map)
  ;; (global-set-key (kbd "²") '2-map)
  ;; (global-set-key (kbd "² ²")
  ;;               '(lambda () (interactive) (insert "²")))
  ;; (global-set-key (kbd "² &")
  ;;               '(lambda () (interactive) (insert "&")))


  ;; (define-prefix-command 'u-map)
  ;; (global-set-key (kbd "ù") 'u-map)
  ;; (global-set-key (kbd "ù ù")
  ;;                 '(lambda () (interactive) (insert "ù")))
  ;; (global-set-key (kbd "ù m")
  ;;                 '(lambda () (interactive) (insert "m")))
  ;; (global-set-key (kbd "ù *")
  ;;                 '(lambda () (interactive) (insert "*")))
  ;; (global-set-key (kbd "ù $")
  ;;                 '(lambda () (interactive) (insert "$")))


  (defun exchange-point-and-mark-no-activate ()
    "Identical to \\[exchange-point-and-mark] but will not activate the region."
    (interactive)
    (exchange-point-and-mark)
    (deactivate-mark nil))
  (define-key global-map [remap exchange-point-and-mark]
    'exchange-point-and-mark-no-activate)

  ;; TODO:
  ;; something something transpose? upcase-word? marks?
  ;; e' to eval region if marked
  ;; search in minibuffer history

  ;; TODO: list free 'mod+key', keys (f1..12, weird stuffs: ù²¨^)
  ;; (bind-key* (kbd *altgr-v*) 'free)
  ;; (bind-key* (kbd *altgr-z*) 'free)
  ;; (bind-key* (kbd *altgr-y*) 'free)
  ;; (bind-key* (kbd *altgr-u*) 'free)
  ;; (bind-key* (kbd *altgr-$*) 'free)
  ;; (bind-key* (kbd *altgr-s*) 'free)
  ;; (bind-key* (kbd *altgr-d*) 'free)
  ;; (bind-key* (kbd *altgr-l*) 'free)
  ;; (bind-key* (kbd *altgr-w*) 'free)
  ;; (bind-key* (kbd *altgr-c*) 'auto-complete-mode)


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
                  (:eval (propertize (if (frame-parameter nil 'client) "@" "")))
                  ;; percent of buffer
                  "%6p "
                  ;; flycheck errors
                  (:eval (when (fboundp 'flycheck-count-errors)
                           (let-alist (flycheck-count-errors flycheck-current-errors)
                             (cond
                              ((and .error .warning)
                               (propertize (format "%s/%s" .error .warning) 'face '(:foreground "black" :background "#cd5542" :weight bold)))
                              (.error
                               (propertize (format "%s" .error) 'face '(:foreground "black" :background "#cd5542" :weight bold)))
                              (.warning
                               (propertize (format "%s" .warning) 'face '(:foreground "black" :background "#df9522" :weight bold)))
                              (t
                               "")))))
                  ;; mail notifications (FIXME: require Inbox open?)
                  (:eval (let ((got-mail (and (boundp 'gnus-newsgroup-unreads) gnus-newsgroup-unreads)))
                           (if got-mail
                               (propertize " M " 'face '(:foreground "black" :background "#dF9522" :weight bold))
                             "  ")))
                  ;; current directory (TODO: short-short-short?)
                  (:eval (propertize (extra-shorten-directory default-directory) 'face '(:weight bold)))
                  "  "
                  ;vc branch
                  (vc-mode vc-mode)
                  ;; actives modes
                  "  "
                  mode-line-modes))

  ;; enable col number
  (column-number-mode 1)

  ;; horizontal scroll
  (put 'scroll-left 'disabled nil))

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
