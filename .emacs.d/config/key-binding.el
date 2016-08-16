;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    key-binding.el                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/15 15:31:08 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/16 01:56:00 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'list-buffers 'ibuffer-other-window)

;; del key workaround
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)

;; mouse scrolling workaround
(bind-key* (kbd "<mouse-4>") 'previous-line)
(bind-key* (kbd "<mouse-5>") 'next-line)

;; TODO
;; auto-complete
(add-hook 'auto-complete-mode-hook
          (lambda()
			(local-set-key [(backtab)] 'auto-complete)
			(define-key ac-menu-map [(next)] 'ac-next)
			(define-key ac-menu-map [(prior)] 'ac-previous)
			(define-key ac-completing-map [down] nil)
			(define-key ac-completing-map [up] nil)
			))

; cpp
(add-hook 'c++-mode-hook
          (lambda()
            (local-unset-key (kbd "M-q"))
			;; (local-set-key (kbd "M-h") 'hpp-template) ; -> elisp-functions.el
			;; (local-set-key (kbd "M-c") 'cpp-template) ; -> elisp-functions.el
			;; (local-set-key (kbd "M-c") 'cpp-get-set-template) ; -> elisp-functions.el
			;; (local-set-key (kbd "M-h") 'hpp-get-set-template)) ; -> elisp-functions.el
			))

;; move
(bind-key* (kbd "M-i") 'previous-line)
(bind-key* (kbd "M-j") 'backward-char)
(bind-key* (kbd "M-k") 'next-line)
(bind-key* (kbd "M-l") 'forward-char)
(bind-key* (kbd "M-u") 'backward-word)
(bind-key* (kbd "M-o") 'forward-word)
(bind-key* (kbd "M-_") 'move-beginning-of-line)
(bind-key* (kbd "M-ç") 'move-end-of-line)
(bind-key* (kbd "M-m") 'normdown) ; -> elisp-functions.el
(bind-key* (kbd "M-p") 'normup) ; -> elisp-functions.el

;; insert pair
(bind-key* (kbd "M-&") 'par) ; -> elisp-functions.el
(bind-key* (kbd "M-é") 'cro) ; -> elisp-functions.el
(bind-key* (kbd "M-\"") 'aco) ; -> elisp-functions.el
(bind-key* (kbd "M-\'") 'guigui) ; -> elisp-functions.el
(bind-key* (kbd "M-(") 'gui) ; -> elisp-functions.el
(bind-key* (kbd "M--") 'inc) ; -> elisp-functions.el

(bind-key* (kbd "M-è") 'main) ; -> elisp-functions.el
(bind-key* (kbd "M-g") 'goto-line)
(bind-key (kbd "<backtab>") 'dabbrev-expand)
(bind-key* (kbd "<f2>") 'kill-region)
(bind-key* (kbd "<f3>") 'kill-ring-save)
(bind-key* (kbd "<f4>") 'yank)
(bind-key* (kbd "<f5>") 'kill-line)
(bind-key* (kbd "<f6>") 'point-to-register)
(bind-key* (kbd "<f7>") 'jump-to-register) ;move
(bind-key* (kbd "<f8>") 'undo)
(bind-key* (kbd "<f9>") 'isearch-forward)
(bind-key* (kbd "<f10>") 'query-replace)
(bind-key* (kbd "<f11>") 'save-buffer)
(bind-key* (kbd "<f12>") 'save-buffers-kill-terminal)
(bind-key* (kbd "M-;") 'semi-c) ; -> elisp-functions.el
(bind-key* (kbd "C-c M-c") 'stuff)
(bind-key* (kbd "<M-prior>") 'previous-multiframe-window)
(bind-key* (kbd "ESC <prior>") 'previous-multiframe-window)
(bind-key* (kbd "<M-next>") 'next-multiframe-window)
(bind-key* (kbd "ESC <next>") 'next-multiframe-window)
(bind-key* (kbd "<M-insert>") 'find-file-other-window)
(bind-key* (kbd "<M-delete>") 'delete-window)
(bind-key* (kbd "<M-up>") 'global-linum-mode)
(bind-key* (kbd "ESC <up>") 'global-linum-mode)
(bind-key* (kbd "<M-down>") 'hs-toggle-hiding)
(bind-key* (kbd "ESC <down>") 'hs-toggle-hiding)
(bind-key* (kbd "<M-left>") 'hs-hide-all)
(bind-key* (kbd "ESC <left>") 'hs-hide-all)
(bind-key* (kbd "<M-right>") 'hs-show-all)
(bind-key* (kbd "ESC <right>") 'hs-show-all)
(bind-key* (kbd "M-s") 'shell-that)
(bind-key* (kbd "C-f") 'find-grep-dired)
(bind-key* (kbd "M-f") 'find-name-dired)
(bind-key* (kbd "C-r") 'rgrep)
(bind-key* (kbd "M-r") 'query-replace-regexp)
(bind-key* (kbd "C-o") 'occur)
(bind-key* (kbd "M-c") 'compile)
(bind-key* (kbd "C-c C-g") 'headcomment) ; -> elisp-functions.el
(bind-key* (kbd "M-q") 'comment) ; -> elisp-functions.el
(bind-key* (kbd "C-q") 'debug) ; -> elisp-functions.el
(bind-key* (kbd "C-i") 'indent-buffer) ; -> elisp-functions.el
(bind-key* (kbd "M-v") 'vc-dir)
(bind-key* (kbd "C-c C-d") 'diff-hl-mode)
(bind-key* (kbd "C-x f") 'find-file)
(bind-key* (kbd "C-x C-f") 'find-file-other-window)
(bind-key* (kbd "C-c C-b") 'erc-switch-to-buffer)
(bind-key* (kbd "C-c )") 'slime-close-all-parens-in-sexp)
(bind-key* (kbd "C-x c") 'copy-killring-to-clipboard) ; -> elisp-functions.el

(bind-key* (kbd "æ") 'tab-to-tab-stop) ;Altgr a
(bind-key* (kbd "¢") 'auto-complete-mode) ;Altgr c
(bind-key* (kbd "ĸ") 'kill-paragraph) ;Altgr k
(bind-key* (kbd "¶") 'transpose-chars) ;Altgr r
(bind-key* (kbd "đ") 'ac-fuzzy-complete) ;Altgr f


;; (bind-key* (kbd "¶") 'transpose-chars) ;Altgr r
;; (bind-key* (kbd "ŧ") '(lambda() (interactive) (transpose-chars -1))) ;Altgr t/o
;; (bind-key* (kbd "đ") 'transpose-words) ;Altgr f
;; (bind-key* (kbd "ŋ") '(lambda() (interactive) (transpose-words -1))) ;Altgr g
;; (bind-key* (kbd "“") 'transpose-lines) ;Altgr v
;; (bind-key* (kbd "”") '(lambda() (interactive) (transpose-lines -1))) ;Altgr b

;; (bind-key* (kbd "ŧ") 'free) ;Altgr t/o
;; (bind-key* (kbd "ŋ") 'free) ;Altgr g
;; (bind-key* (kbd "“") 'free) ;Altgr v
;; (bind-key* (kbd "”") 'free) ;Altgr b
;; (bind-key* (kbd "→") 'free) ;Altgr i
;; (bind-key* (kbd "ø") 'free) ;Altgr o
;; (bind-key* (kbd "þ") 'free) ;Altgr p
;; (bind-key* (kbd "«") 'free) ;Altgr z
;; (bind-key* (kbd "←") 'free) ;Altgr y
;; (bind-key* (kbd "↓") 'free) ;Altgr u
;; (bind-key* (kbd "¤") 'free) ;Altgr $
;; (bind-key* (kbd "ß") 'free) ;Altgr s
;; (bind-key* (kbd "ð") 'free) ;Altgr d
;; (bind-key* (kbd "̉ħ") 'free) ;Altgr h
;; (bind-key* (kbd "ł") 'free) ;Altgr l/w
;; (bind-key* (kbd "µ") 'free) ;Altgr m
;; (bind-key* (kbd "»") 'free) ;Altgr x

;; zboub
