;;; init-tuareg.el --- init tuareg
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-tuareg.el                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/10/11 16:25:37 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package tuareg
  :ensure t

  :init
  (progn
    (use-package merlin
      :ensure t

      :init
      (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
        (when (and opam-share (file-directory-p opam-share))
          ;; Register Merlin
          (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
          (autoload 'merlin-mode "merlin" nil t nil)

          ;; Automatically start it in OCaml buffers
          (add-hook 'tuareg-mode-hook 'merlin-mode t)
          (add-hook 'caml-mode-hook 'merlin-mode t)

          ;; Use opam switch to lookup ocamlmerlin binary
          (setq merlin-command 'opam))))


    (use-package flycheck-ocaml
      :ensure t

      :init
      (with-eval-after-load 'merlin
        ;; Disable Merlin's own error checking
        (setq merlin-error-after-save nil)

        ;; Enable Flycheck checker
        (flycheck-ocaml-setup))

      (add-hook 'tuareg-mode-hook #'merlin-mode))

    (use-package utop
      :ensure t

      :init
      (setq utop-command "opam config exec -- utop -emacs")
      (add-hook 'tuareg-mode-hook 'utop-minor-mode)

      :config
      (define-key utop-minor-mode-map (kbd "C-c C-c") 'utop-eval-dwim)
      (define-key utop-mode-map (kbd "<C-up>") 'utop-history-goto-prev)
      (define-key utop-mode-map (kbd "<C-down>") 'utop-history-goto-next)))


  :mode
  ("\\.ml\\'" . tuareg-mode)
  ("\\.mli\\'" . tuareg-mode))


(defun utop-eval-dwim ()
  "Eval region if there is one, otherwise eval buffer."
  (interactive)
  (if (or (not transient-mark-mode) (region-active-p))
      (utop-eval-region (region-beginning) (region-end))
    (utop-eval-buffer)))


(provide 'init-tuareg)
;;; init-tuareg.el ends here
