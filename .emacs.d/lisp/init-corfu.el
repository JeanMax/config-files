;;; init-corfu.el --- init corfu
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-corfu.el                                      :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 11:49:07 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(use-package corfu
  :ensure t
  :defer t
  ;; :bind (("TAB" . indent-or-complete))
  :config
  ;; (setq corfu-auto t)
  (setq corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (setq corfu-separator ?\s)          ;; Orderless field separator
  ;; (setq corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (setq corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (setq corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (setq corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (setq corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (setq corfu-scroll-margin 5)        ;; Use scroll margin
  (setq corfu-preview-current nil)

  :bind
  (:map corfu-map
        ;; ("RET" . nil)
        ("C-d" . corfu-info-documentation)
        ("C-l" . corfu-info-location)
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  ;; :init
  ;; (global-corfu-mode)
  )


(use-package cape
  :ensure t
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)

  (when (< emacs-major-version 29)
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)))


(use-package nerd-icons-corfu
  :ensure t
  :after (corfu)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))


(use-package corfu-terminal
  :ensure t
  :after (corfu)
  :init (corfu-terminal-mode +1))


;; TODO: not ensure'able
;; (use-package corfu-doc-terminal
;;   :ensure t
;;   :after (corfu)
;;   :init (corfu-doc-terminal-mode +1))

;; this is nice but a bit intrusive
;; (use-package corfu-candidate-overlay
;;   :ensure t
;;   :after corfu
;;   :config
;;   ;; enable corfu-candidate-overlay mode globally
;;   ;; this relies on having corfu-auto set to nil
;;   (corfu-candidate-overlay-mode +1)
;;   ;; bind Ctrl + TAB to trigger the completion popup of corfu
;;   ;; (global-set-key (kbd "C-<tab>") 'completion-at-point)
;;   ;; bind Ctrl + Shift + Tab to trigger completion of the first candidate
;;   ;; (keybing <iso-lefttab> may not work for your keyboard model)
;;   ;; (global-set-key (kbd "C-<iso-lefttab>") 'corfu-candidate-overlay-complete-at-point)
;;   )



;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  ;; :bind (("M-/" . dabbrev-completion)
  ;;        ("C-M-/" . dabbrev-expand))
  :config
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
  ;; TAB cycle if there are only few candidates
  ;; (setq completion-cycle-threshold 3)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)
  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (setq text-mode-ispell-word-completion nil)
  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (setq read-extended-command-predicate #'command-completion-default-include-p)
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  ;; Since 29.1, use `dabbrev-ignored-buffer-regexps' on older.
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)



  (defun indent-or-complete ()
    (interactive)
    (if (and corfu-mode (looking-at "\\_>"))
        (completion-at-point)
      (if (or (not transient-mark-mode) (region-active-p))
          (indent-region (region-beginning) (region-end))
        (indent-according-to-mode)))))








;; (use-package company
;;   :ensure t
;;   :defer t
;;   :diminish company-mode

;;   :bind (("TAB" . indent-or-complete))

;;   ;; :init
;;   ;; (add-hook 'after-init-hook 'global-company-mode)
;;   ;; (add-hook 'prog-mode-hook 'company-mode)
;;   ;; (add-hook 'minibuffer-inactive-mode 'company-mode)

;;   :config
;;   (progn
;;     (setq company-require-match 'never)
;;     (setq company-backends '((company-files
;;                               company-keywords
;;                               company-capf
;;                               company-abbrev
;;                               company-dabbrev
;;                               company-dabbrev-code
;;                               company-etags
;;                               company-gtags)))
;;     ;; (setq company-echo-delay 0)
;;     (setq company-idle-delay nil) ; do not autostart
;;     ;; (setq company-idle-delay 0.1)
;;     (setq company-minimum-prefix-length 1) ; 0 to complete '.'
;;     ;; (setq company-show-numbers t)


;;   (use-package company-statistics
;;     :ensure t
;;     :defer t

;;     :init
;;     (add-hook 'company-mode-hook 'company-statistics-mode)

;;     :config
;;     (progn
;;       ;; (define-key company-active-map (kbd "RET") nil)
;;       ;; (define-key company-active-map (kbd "<down>") nil)
;;       ;; (define-key company-active-map (kbd "<up>") nil)
;;       (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
;;       (define-key company-active-map (kbd "C-j") 'company-complete-selection)
;;       ;; (define-key company-active-map (kbd "<backtab>") 'company-complete-selection)
;;       (define-key company-active-map (kbd "<backtab>") 'company-select-previous-or-abort)
;;       (define-key company-active-map (kbd "<next>") 'company-select-next-or-abort)
;;       (define-key company-active-map (kbd "<prior>") 'company-select-previous-or-abort)

;;       ;; (setq company-statistics-file "~/.emacs.d/misc/company-statistics-cache.el")
;; 	  ))




(provide 'init-corfu)
;;; init-corfu.el ends here
