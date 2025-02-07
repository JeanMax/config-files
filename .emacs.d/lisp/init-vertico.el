;;; init-vertico.el --- init vertico
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-vertico.el                                      :+:      :+:    :+:  ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:08:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; TODO: add buffer menu shortcut (kill-buffer -f or rm file)
;; multiselect?
;; compilation-mode: no vertico completion?
(use-package vertico
  :defines crm-separator
  ;TODO: use :defines :functions everywhere, and handle all the missing 'require

  :ensure t
  :bind (:map vertico-map
              ("TAB" . #'vertico-insert-or-next)
              ("M-o" . #'vertico-insert)
              ("RET" . #'vertico-directory-enter)
              ("DEL" . #'vertico-directory-delete-char)
              ("C-d" . #'vertico-exit-input)
              ("C-q" . #'embark-act)
              ("?" . #'minibuffer-completion-help)
              ;; ("<backtab>" . 'vertico-previous)  ;; this would disable dabbrev :/
              )
  :hook ((rfn-eshadow-update-overlay . vertico-directory-tidy) ; Clean up file path when typing
         (minibuffer-setup . vertico-repeat-save)) ; Make sure vertico state is saved
  :init
  (vertico-mode)
  (bind-key* (kbd "C-M-x") 'vertico-repeat)

  ;; TODO: move mouse / X handling to another file
  (vertico-mouse-mode)
  (setq blink-cursor-mode nil)



  ;; ido-ish
  (setq vertico-preselect 'first)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; (vertico-reverse-mode)
  ;; (vertico-flat-mode)  ;; ido-like
  ;; (vertico-grid-mode)  ;; zsh-like

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t))

(defun vertico-insert-or-next ()
  "Insert current candidate in minibuffer or cycle to the next one."
  (interactive)
  (if (<= vertico--total 1)
      (vertico-insert)
    (vertico-next)))


(defun down-from-outside ()
  "Move to next candidate in minibuffer, even when minibuffer isn't selected."
  (interactive)
  (with-selected-window (active-minibuffer-window)
    (execute-kbd-macro [down])))

(defun up-from-outside ()
  "Move to previous candidate in minibuffer, even when minibuffer isn't selected."
  (interactive)
  (with-selected-window (active-minibuffer-window)
    (execute-kbd-macro [up])))

(defun to-and-fro-minibuffer ()
  "Go back and forth between minibuffer and other window."
  (interactive)
  (if (window-minibuffer-p (selected-window))
      (select-window (minibuffer-selected-window))
    (select-window (active-minibuffer-window))))



(defun force-debug (func &rest args)
  (condition-case e
      (apply func args)
    ((debug error) (signal (car e) (cdr e)))))

(advice-add #'vertico--exhibit :around #'force-debug)



;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Support opening new minibuffers from inside existing minibuffers.
  (setq enable-recursive-minibuffers t)

  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (setq read-extended-command-predicate #'command-completion-default-include-p))


(provide 'init-vertico)
;;; init-vertico.el ends here
