;;; init-ibuffer.el --- init ibuffer
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-ibuffer.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/25 16:18:40 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package ibuffer
  :defer t

  :config
  (setq ibuffer-saved-filter-groups
        '(("home"
           ("Git" (or (name . "^\*vc-.*\*$")
                      (name . "^timemachine:.*")))
           ("Base" (filename . ".*/Base.*\\.php$")) ;tmp
           ("Rest" (filename . ".*/Rest/.*\\.php$")) ;tmp
           ("Web" (filename . ".*/Web/.*\\.php$")) ;tmp
           ("Views" (filename . ".*\\.twig$")) ;tmp
           ("Tests" (filename . ".*/Tests/.*\\.php$")) ;tmp
           ("Server" (filename . ":.*:")) ;tmp
           ("C" (filename . ".*\\.c$"))
           ("H" (filename . ".*\\.h$"))
           ("Php" (filename . ".*\\.php$"))
           ("Yaml" (filename . ".*\\.yml$"))
           ("Sh" (filename . ".*\\.sh$"))
           ("Dir" (mode . dired-mode))
           ("eLisp" (filename . ".*\\.el$"))
           ("Bookmarks" (or (name . "*Bookmark List*")
                            (name . "*Open Recent*")))
           ("Compilation" (name . "*compilation*"))
           ("Mail" (or (mode . message-mode)
                       (mode . bbdb-mode)
                       (mode . mail-mode)
                       (mode . gnus-group-mode)
                       (mode . gnus-summary-mode)
                       (mode . gnus-article-mode)
                       (name . "^\\.bbdb$")
                       (name . "^\\.newsrc-dribble")))
           ("Irc" (mode . erc-mode))
           ("*.*" (or (name . "^\*.*\*$")
                      (name . "TAGS"))))))
  (setq ibuffer-expert t)
  (setq ibuffer-show-empty-filter-groups nil)
  (add-hook 'ibuffer-mode-hook
            '(lambda ()
               (ibuffer-auto-mode 1)
               (ibuffer-switch-to-saved-filter-groups "home")))
  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
    (:name "Size")
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))
  ;; Modify the default ibuffer-formats
  (setq ibuffer-formats
        '((mark modified read-only " "
                (name 18 18 :left :elide)
                " "
                (size-h 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                filename-and-process)))
 (setq ibuffer-default-sorting-mode 'alphabetic)
 (setq ibuffer-fontification-alist
       '((10 buffer-read-only
             font-lock-constant-face)
         (15 (and buffer-file-name
                  (string-match ibuffer-compressed-file-name-regexp buffer-file-name))
             font-lock-doc-face)
         (20 (string-match "^*"  (buffer-name))
             font-lock-function-name-face)
         (25 (and (string-match "^ " (buffer-name))
                  (null buffer-file-name))
             italic)
         (30 (memq major-mode ibuffer-help-buffer-modes)
             font-lock-comment-face)
         (35 (eq major-mode 'dired-mode)
             font-lock-keyword-face)
         (12 (eq major-mode 'erc-mode)
             font-lock-type-face)
         (10 (eq major-mode 'emacs-lisp-mode)
             font-lock-variable-name-face))))

(bind-key* (kbd *altgr-s*) 'ibuffer)
(defalias 'list-buffers 'ibuffer-other-window)

(provide 'init-ibuffer)
;;; init-ibuffer.el ends here
