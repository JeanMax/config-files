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
;    Updated: 2019/09/29 14:43:15 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package emacs
  :init
  (use-package diminish
    :ensure t)

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

    ;alternative french?
    ;; (defconst *altgr-a* "æ")
    ;; (defconst *altgr-z* "«")
    ;; (defconst *altgr-e* "€")
    ;; (defconst *altgr-r* "¶")
    ;; (defconst *altgr-t* "ŧ")
    ;; (defconst *altgr-y* "←")
    ;; (defconst *altgr-u* "↓")
    ;; (defconst *altgr-i* "→")
    ;; (defconst *altgr-o* "ø")
    ;; (defconst *altgr-p* "þ")
    ;; (defconst *altgr-q* "@")
    ;; (defconst *altgr-s* "ß")
    ;; (defconst *altgr-d* "ð")
    ;; (defconst *altgr-f* "đ")
    ;; (defconst *altgr-g* "ŋ")
    ;; (defconst *altgr-h* "ħ")
    ;; (defconst *altgr-j* "")
    ;; (defconst *altgr-k* "ĸ")
    ;; (defconst *altgr-l* "ł")
    ;; (defconst *altgr-m* "µ")
    ;; (defconst *altgr-w* "ł")
    ;; (defconst *altgr-x* "»")
    ;; (defconst *altgr-c* "¢")
    ;; (defconst *altgr-v* "“")
    ;; (defconst *altgr-b* "”")
    ;; (defconst *altgr-n* "n")
    ;; (defconst *altgr-$* "¤"))


    ;default french
    (defconst *console* "²")
    (defconst *altgr-a* "æ")
    (defconst *altgr-z* "â")
    (defconst *altgr-e* "€")
    (defconst *altgr-r* "ê") ; I use that :/
    (defconst *altgr-t* "þ")
    (defconst *altgr-y* "ÿ")
    (defconst *altgr-u* "û")
    (defconst *altgr-i* "î")
    (defconst *altgr-o* "œ")
    (defconst *altgr-p* "ô")
    (defconst *altgr-q* "ä")
    (defconst *altgr-s* "ß")
    (defconst *altgr-d* "ë")
    (defconst *altgr-f* "‘")
    (defconst *altgr-g* "’")
    (defconst *altgr-h* "ð")
    (defconst *altgr-j* "ü")
    (defconst *altgr-k* "ï")
    (defconst *altgr-l* "ŀ")
    (defconst *altgr-m* "ö")
    (defconst *altgr-w* "«")
    (defconst *altgr-x* "»")
    (defconst *altgr-c* "©")
    (defconst *altgr-v* " ")
    (defconst *altgr-b* "↓")
    (defconst *altgr-n* "¬")
    (defconst *altgr-$* "ø"))
  ;TODO: add a variable to configure this at runtime


  (when *is-rxvt*
    ;; (define-key function-key-map "\033[1;5A" [(control up)])
    ;; (define-key function-key-map "\033[1;5B" [(control down)])
    ;; (define-key function-key-map "\033[1;5D" [(control left)])
    ;; (define-key function-key-map "\033[1;5C" [(control right)])
    ;; (define-key function-key-map "\033[1;2A" [(shift up)])
    ;; (define-key function-key-map "\033[1;2B" [(shift down)])
    ;; (define-key function-key-map "\033[1;2D" [(shift left)])
    ;; (define-key function-key-map "\033[1;2C" [(shift right)])

    ;control-del fix
    (define-key function-key-map "\033[3;5~" [(control delete)])


    ;control-shift fix
    (define-key function-key-map "\033[1;6A" [(control shift up)])
    (define-key function-key-map "\033[1;6B" [(control shift down)])
    (define-key function-key-map "\033[1;6D" [(control shift left)])
    (define-key function-key-map "\033[1;6C" [(control shift right)]))

  ;; tell emacs where to read abbrev
  (setq save-abbrevs 'silently)
  ;; (setq abbrev-file-name "~/.emacs.d/misc/abbrev_defs")

  ;; eshell
  ;; (setq eshell-directory-name "~/.emacs.d/misc/eshell")

  ;; encoding
  (set-language-environment "UTF-8")

  ;; indentation
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil) ; TODO: set to t later for 42-mode
  (setq-default tab-stop-list (number-sequence 4 200 4))
  (setq fill-column 80)

  ;; disable top menu bar
  (menu-bar-mode -1)
  (tool-bar-mode -1)

  ;; splash screen on old versions...
  (setq inhibit-splash-screen t)

  ;; default major mode (used for *scratch*)
  (setq initial-major-mode 'text-mode)
  (setq initial-scratch-message "")
  ;; (setq initial-scratch-message "#!/bin/bash -ex\n\n")

  ;; Don't show *Buffer list* when opening multiple files at the same time.
  (setq inhibit-startup-buffer-menu t)

  ;; no *scratch* at startup, use the previous buffer
  (when *is-a-server*
    (setq initial-buffer-choice
          '(lambda ()
             (switch-to-buffer (other-buffer (current-buffer) t)))))

  ;; format line number (fringe)
  (setq linum-format "%3d ")

  ;; Ignore case when completing file/buffer names
  (setq read-file-name-completion-ignore-case 't)
  (setq read-buffer-completion-ignore-case 't)

  ;; completion stuffs
  (setq dabbrev-case-distinction nil)
  (setq dabbrev-case-fold-search nil)
  (setq dabbrev-case-replace nil)
  (setq hippie-expand-dabbrev-skip-space t)
  (setq hippie-expand-try-functions-list '(try-expand-list
										   try-expand-line
										   try-complete-file-name-partially
										   try-complete-file-name
										   try-expand-all-abbrevs
										   try-expand-dabbrev
										   try-expand-dabbrev-all-buffers
										   try-expand-dabbrev-from-kill
										   try-complete-lisp-symbol-partially
										   try-complete-lisp-symbol))

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
  (setq auto-save-list-file-prefix "~/.emacs.d/auto-save-list/saves-")
  (setq auto-save-file-name-transforms `((".*" ,"~/.emacs.d/backup" t)))

  ;; bookmark
  ;; (when *is-a-server*
    ;; (bookmark-bmenu-list))
  ;; (setq bookmark-file "~/.emacs.d/misc/bookmarks")
  ;; (bookmark-set)
  ;; (bookmark-jump)
  ;; (list-bookmarks)

  ;calendar
  (setq calendar-date-style (quote european))
  (setq calendar-week-start-day 1)

  (defalias 'yes-or-no-p 'y-or-n-p)

  ;; del key workaround
  (global-set-key (kbd "DEL") 'backward-delete-char)
  (setq-default c-backspace-function 'backward-delete-char)

  ;; trying to mimic terminal behaviour in gui
  (global-set-key (kbd "C-S-c") 'kill-ring-save)
  (global-set-key (kbd "C-S-V") 'clipboard-yank)
  (global-set-key (kbd "C-S-t") 'shell)

  ;; mouse scrolling workaround
  (bind-key* (kbd "<mouse-4>") 'previous-line)
  (bind-key* (kbd "<mouse-5>") 'next-line)

  ;; linum
  (cond
   ((version< emacs-version "23")
    (bind-key* (kbd "<A-up>") 'linum-mode))
   ((version< "25" emacs-version)
    (bind-key* (kbd "<A-up>") 'display-line-numbers-mode)
   ;we keep this for gui-macs
    (bind-key* (kbd "<M-up>") 'display-line-numbers-mode))
   (t
    (bind-key* (kbd "ESC <up>") 'linum-mode)
   ;we keep this for gui-macs
    (bind-key* (kbd "<M-up>") 'linum-mode)))

  ;; search and replace
  (bind-key* (kbd "<f10>") 'query-replace)
  ;; (bind-key* (kbd "C-r") 'rgrep)
  (bind-key* (kbd "C-r") 'isearch-backward)
  (bind-key* (kbd "M-r") 'query-replace-regexp)
  (bind-key* (kbd "C-o") 'occur)

  ;; completion
  (bind-key (kbd "<backtab>") 'dabbrev-expand)
  (bind-key* (kbd *altgr-h*) 'hippie-expand)

  ;; registers
  (bind-key* (kbd "<f7>") 'point-to-register)
  (bind-key* (kbd "<f9>") 'jump-to-register)
  ;; (bind-key* (kbd *altgr-m*) 'point-to-register)

  ;; misc
  (bind-key* (kbd "M-s") 'shell)
  (bind-key* (kbd "M-c") 'compile)
  (bind-key* (kbd "M-q") 'comment) ; -> elisp-functions.el
  (bind-key* (kbd "C-q") 'insert-debug-comment) ; -> elisp-functions.el

  ;; gui font (default is actually set in .Xressources)
  (when (member "CodeNewRoman" (font-family-list))
    (set-frame-font "CodeNewRoman 12" t nil))
  (when (member "Symbola" (font-family-list))
    (set-fontset-font t 'unicode "Symbola" nil 'prepend))

  ;; (setq default-frame-alist '((font . "CodeNewRoman-13")))

  ;; delay before printing prefix key(s) in the messages bar
  (setq suggest-key-bindings 0)


  ;; full width man
  (setq Man-width t)

  (defun exchange-point-and-mark-no-activate ()
    "Identical to \\[exchange-point-and-mark] but will not activate the region."
    (interactive)
    (exchange-point-and-mark)
    (deactivate-mark nil))
  (define-key global-map [remap exchange-point-and-mark]
    'exchange-point-and-mark-no-activate)


  (require 'ansi-color)
  (defun endless/colorize-compilation ()
    "Colorize from `compilation-filter-start' to `point'."
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region
       compilation-filter-start (point))))
  (add-hook 'compilation-filter-hook #'endless/colorize-compilation)

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
                  (:eval (let ((got-mail (and (boundp 'gnus-newsgroup-unreads)
											  (string-match ".*\\([0-9]+\\).*: \\[Gmail\\]/Tous.*"
															(with-current-buffer "*Group*" (buffer-string))))))
                           (if got-mail
                               (propertize " M " 'face '(:foreground "black" :background "#dF9522" :weight bold))
                             "  ")))
                  ;; current directory (TODO: short-short-short?)
                  (:eval (propertize (extra-shorten-directory default-directory) 'face '(:weight bold)))
                  "  "
                  ;vc branch
                  ;; (vc-mode vc-mode)
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


;; ansi colors in compilation buffer
(require 'ansi-color)

(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(provide 'init-emacs)
;;; init-emacs.el ends here
