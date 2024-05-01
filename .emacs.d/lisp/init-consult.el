;;; init-consult.el --- init consult
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-consult.el                                      :+:      :+:    :+:  ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2018/02/18 12:08:00 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
  ;;        ("C-c M-x" . consult-mode-command)
  ;;        ;; C-x bindings in `ctl-x-map'
  ;;        ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command

  ;;        ;; Other custom bindings
  ;;        ("M-y" . consult-yank-pop)                ;; orig. yank-pop

  ;;        ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)

  ;;        ;; M-s bindings in `search-map'
         ;; TODO: tweak this so you could enter the root dir, and skip fd filtering (just throw a '.'; you might also want to add a '--type f')
         ("M-s d" . consult-fd)
         ("M-s r" . consult-ripgrep) ;;TODO: allow to choose base dir / filter files

         ("M-s l" . consult-line)  ;; -> occur
         ("M-s L" . consult-line-multi)  ;; -> multi-occur
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)

  ;;        ;; Isearch integration
         ;; ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         )

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5)
  (setq register-preview-function #'consult-register-format)
  (setq consult-line-start-from-top t)
  (setq consult-fd-args
        '((if (executable-find "fdfind" 'remote)
              "fdfind" "fd")
          "--full-path --color=never" "--hidden" "--exclude .git" "--type f"))
  (setq consult-ripgrep-args
        "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --with-filename --line-number --search-zip --hidden --follow")
  (setq xref-search-program 'ripgrep)

  ;; Use Consult to select xref locations with preview
  ;; (setq xref-show-xrefs-function #'consult-xref
  ;;       xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   consult-buffer
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 3. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  ;;;; 4. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 5. No project support
  ;; (setq consult-project-function nil)
)


(bind-key* (kbd "<f7>") 'consult-register-store)
(bind-key* (kbd "<f9>") 'consult-register-load)
(require 'altgr)
(keymap-set bookmark-map *altgr-$* 'consult-bookmark)
(bind-key* (kbd *altgr-$*) 'bookmark-map)
(bind-key* (kbd *altgr-b*) 'consult-buffer)



(use-package consult-dir
  :ensure t
  :bind (("C-x C-d" . consult-dir)
         :map vertico-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file))

  :config
  (defun consult-dir--fd-dirs-in-project ()
    "Return list of dirs in project (using fd)."
    (let ((command (format
                    "fd --color never --print0 --hidden --exclude .git --type d . %s | sort -z | uniq -z"
                    (cdr (project-current t)))))
      (split-string (shell-command-to-string command) "\0" t)))

  (defvar consult-dir--source-fd-in-project
    `(:name     "Project dirs"
                :narrow   ?f
                :category file
                :face     consult-file
                :history  file-name-history
                :enabled  ,(lambda () (executable-find "fd"))
                :items    ,#'consult-dir--fd-dirs-in-project)
    "Fd directory source for `consult-dir'.")

  (add-to-list 'consult-dir-sources 'consult-dir--source-fd-in-project t))



(use-package wgrep
  :ensure t)



(provide 'init-consult)
;;; init-consult.el ends here
