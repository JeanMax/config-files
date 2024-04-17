;;; init-ido.el --- init ido
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ido.el                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/04/08 09:23:46 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package ido
  ;; :defer t

  :init
  (ido-mode 1)

  :config
  (progn

    (ido-everywhere 1)
    (setq ido-enable-dot-prefix t)
    (setq ido-enable-flex-matching nil)
    (setq ido-file-extensions-order nil)
    (setq ido-ignore-files '("\\`CVS/"
                             "\\`#" "\\`.#"
                             "\\`\\.\\./"
                             "\\`\\./"
                             "__pycache__"))
    (setq safe-local-variable-values '((py-indent-offset . 4)))


    ;; (setq ido-save-directory-list-file "~/.emacs.d/misc/ido.last")
    ;; #ebc481 is some kind shiny yellow
    (set-face-attribute 'ido-first-match t :foreground "#ebc481") ;TODO: highlight?
    (set-face-attribute 'ido-subdir t :foreground ample/blue)

    (add-hook 'ido-setup-hook (lambda ()
                                (define-key ido-completion-map (kbd "TAB") 'ido-complete)
                                (define-key ido-completion-map (kbd "<C-up>") 'previous-line-or-history-element)
                                (define-key ido-completion-map (kbd "<C-down>") 'next-line-or-history-element)
                                ;; (define-key ido-completion-map (kbd "C-l") 'ido-to-end)
                                (define-key ido-completion-map (kbd "C-r") 'previous-matching-history-element)
                                (define-key ido-completion-map (kbd "C-s") 'next-matching-history-element)
								))))


(use-package ido-completing-read+
  :ensure t
  :after (ido)
  ;; :defer t

  :init
  (ido-ubiquitous-mode 1))


(use-package flx-ido
  :ensure t
  :after (ido)
  ;; :defer t

  :init
  (flx-ido-mode 1))

(use-package smex
  :after (ido)
  :ensure t
  ;; :defer t

  :init
  ;; (setq smex-save-file "~/.emacs.d/misc/smex-items")
  (smex-initialize)

  :config
  (setq smex-history-length 25))

(use-package ido-complete-space-or-hyphen
  :load-path "~/.emacs.d/site-lisp/ido-complete-space-or-hyphen"
  :after (ido)
  ;; :defer t
  :config
  (ido-complete-space-or-hyphen-mode 1))


(use-package ido-grid-mode
  :if (version< "24.4" emacs-version)
  :after (ido)
  :ensure t
  ;; :defer t
  :init
  (ido-grid-mode t)

  :config
  (set-face-attribute 'ido-grid-mode-match t :weight 'bold) ;TODO: highlight?
  ;; (setq ido-grid-mode-keys nil)
  ;; (setq ido-grid-mode-first-line '(ido-grid-mode-count "   " ido-grid-mode-long-count))
  (setq
   ido-grid-mode-max-columns 9
   ido-grid-mode-max-rows 3
   ido-grid-mode-min-rows 3
   ;; ido-grid-mode-prefix-scrolls t
   ;; ido-grid-mode-scroll-down #'ido-grid-mode-next-row
   ;; ido-grid-mode-scroll-up #'ido-grid-mode-previous-row
   ;; ido-grid-mode-order nil
   ;; ido-grid-mode-start-collapsed t
   ))


;; (use-package ido-at-point
;;   :ensure t
;;   :bind (("TAB" . indent-or-complete))

;;   :init
;;   ;;TODO: cf company
;;   (defun indent-or-complete () ;TODO: upgrade it! (cf ~smart-indent or something like that)
;;     (interactive)
;;     (if (looking-at "\\_>")
;;         (completion-at-point)
;;       (if (or (not transient-mark-mode) (region-active-p))
;;           (indent-region (region-beginning) (region-end))
;;         (indent-according-to-mode))))
;;   (ido-at-point-mode 1))





(bind-key (kbd "M-x") 'smex)
(bind-key (kbd "M-X") 'smex-major-mode-commands)


;;move these to etags?
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))
;; (bind-key (kbd *altgr-o*) 'ido-find-file-in-tag-files)

(provide 'init-ido)
;;; init-ido.el ends here
