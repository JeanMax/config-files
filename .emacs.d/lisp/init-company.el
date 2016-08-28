;;; init-company.el --- init company
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-company.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/28 03:58:39 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package company
  :ensure t
  :defer t
  :diminish company-mode

  :bind (("TAB" . indent-or-complete))

  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'minibuffer-inactive-mode 'company-mode)

  :config
  (progn
    (setq company-backends '((company-files
                              company-keywords
                              company-capf
                              company-abbrev
                              company-dabbrev
                              company-dabbrev-code
                              company-etags
                              company-gtags)))
    (setq company-echo-delay 0)
    (setq company-idle-delay nil) ; do not autostart
    (setq company-minimum-prefix-length 1) ; 0 to complete '.'
    ;; (setq company-show-numbers t)


  (use-package company-statistics
    :ensure t
    :defer t

    :init
    (add-hook 'company-mode-hook 'company-statistics-mode)

    :config
    (setq company-statistics-file "~/.emacs.d/misc/company-statistics-cache.el")))

  (defun complete-or-indent ()
    (interactive)
    (if (company-manual-begin)
        (company-complete-common)
      (indent-according-to-mode)))

  (defun indent-or-complete ()
    (interactive)
    (if (looking-at "\\_>")
        (company-complete-common)
      (if (or (not transient-mark-mode) (region-active-p))
          (indent-region (region-beginning) (region-end))
        (indent-according-to-mode)))))


;; TODO
(add-hook 'company-mode-hook
          (lambda()
            ;; (define-key company-active-map (kbd "RET") nil)
            ;; (define-key company-active-map (kbd "<down>") nil)
            ;; (define-key company-active-map (kbd "<up>") nil)
            (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
            ;; (define-key company-active-map (kbd "<backtab>") 'company-complete-selection)
            (define-key company-active-map (kbd "<backtab>") 'company-select-previous-or-abort)
            (define-key company-active-map (kbd "<next>") 'company-select-next-or-abort)
            (define-key company-active-map (kbd "<prior>") 'company-select-previous-or-abort)))

(provide 'init-company)
;;; init-company.el ends here