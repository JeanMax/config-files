;;; init-package.el --- init package
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-package.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2017/07/30 23:39:05 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:


(if (version< emacs-version "24")
    (progn
      (defun bind-key (key command) (global-set-key key command))
      (defun bind-key* (key command) (bind-key key command))
      (defmacro use-package (name &rest args)
        ;; (message "---%s---" args)   ;DEBUG

        (defun eval-loop (l)
          (cond
           ((not l) nil)

           ((or (eq (car l) ':diminish)
                (eq (car l) ':defines)
                (eq (car l) ':commands)
                (eq (car l) ':defer))
            (eval-loop (cddr l)))

           ((eq (car l) ':ensure) ;TODO: clone-package
            nil)

            ((eq (car l) ':mode)
            ;; (message "* Auto-mode: %s *" (cadr l)) ;DEBUG
            (add-to-list 'auto-mode-alist (cadr l))
            ;; (message "* Require: %s *" name) ;DEBUG
            (require name)
            (eval-loop (cddr l)))

           ((eq (car l) ':load-path)
            ;; (message "* Load-path: %s *" (cadr l)) ;DEBUG
            (add-to-list 'load-path (cadr l))
            ;; (message "* Require: %s *" name) ;DEBUG
            (require name)
            (eval-loop (cddr l)))

           ((or (eq (car l) ':init)
                (eq (car l) ':config))
            ;; (message "* Require: %s *" name) ;DEBUG
            (require name)
            (eval-loop (cdr l)))

           (t
            ;; (message "* Eval: %s *" (car l)) ;DEBUG
            (eval (car l))
            (eval-loop (cdr l)))))

        (eval-loop args)))

  (require 'package)
  (setq package-enable-at-startup nil)
  ;; (setq nsm-settings-file "~/.emacs.d/misc/network-security.data")
  (setq package-archives
        '(("marmalade" . "http://marmalade-repo.org/packages/")
          ("melpa" . "http://melpa.org/packages/")
          ("gnu" . "http://elpa.gnu.org/packages/")))
  (package-initialize)

  ;; Bootstrap `use-package'
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile
    (require 'use-package))
  (require 'diminish)
  (require 'bind-key)
  (when *is-a-server*
    (setq use-package-verbose t)))

;; (defun clone-package (package git)
;;   "Ugly hack to clone PACKAGE from GIT url when package.el is missing."
;;     (let ((folder (concat "~/.emacs.d/site-lisp/" package)))
;;       (when ((file-exists-p folder))
;;         (message "* %s *" (concat "git clone " git " " folder))
;;         (shell-command (concat "git clone " git " " folder)))
;;       (add-to-list 'load-path folder)
;;       (load (concat package ".el"))))

(provide 'init-package)
;;; init-package.el ends here
