;; -*- lexical-binding: t -*-
;;; init-project.el --- init project
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-project.el                                    :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/05/09 09:22:12 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;TODO: it seems like runnning find-file-in-all-projects fucks up the cache, then
;      the next calls to project-find-file are looking in all projects
;      (note: running project-find-file in 2 differents projects works as expected)


;;; Code:
;; TODO: overide global key bind for project specific
;; (ie: if in project, M-c trigger project-compile)
(use-package project
  :bind-keymap ("£" . project-prefix-map)
  :bind (:map project-prefix-map
              ("F" . 'find-file-in-all-projects)
              ("b" . 'consult-project-buffer)
              ("l" . 'consult-fd)

              ("f" . 'project-find-file)
              ("d" . 'consult-dir)
              ("g" . 'consult-ripgrep)
              ("v" . 'magit-project-full)
              ("s" . 'eat-project-other-window)
              ; c
              ("k" . 'project-rm)
              )
  :config
  (add-to-list 'project-find-functions #'project-find-root)
  (setq project-vc-merge-submodules t)
  (setq project-switch-use-entire-map t)
  (setq project-switch-commands
        '((project-find-file "File" nil)
          (consult-dir "Dir" nil)
          (consult-ripgrep "Grep" nil)
          (magit-project-full "Magit" nil)
          (eat-project-other-window "Shell" nil)
          (project-compile "Compile" nil)
          (project-rm "Kill" nil))))



(defun project-rm ()
  "Remove current project from projects list and kill all its buffers."
  (interactive)
  (project-kill-buffers t)
  (project-forget-project (cdr (project-current t)))
  (project-forget-zombie-projects))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (require 'filenotify)


;; (defmacro alist-pop (key alist)
;;   `(let ((result (assoc ,key ,alist)))
;;      (setq ,alist (delete result ,alist))
;;      result))


;; (defvar watch-dir-alist nil)

;; (defun add-watch (dir)
;;   "Pouet DIR."
;;   (message "Watching %s" dir)
;;   (add-to-list 'watch-dir-alist
;;                (cons dir (file-notify-add-watch dir
;;                                               '(change
;;                                                 ;; attribute-change
;;                                                 )
;;                                               'my-notify-callback))))


;; (defun rm-watch (dir)
;;   "Pouet DIR."
;;   (file-notify-rm-watch (alist-pop dir watch-dir-alist)))


;; (defun my-notify-callback (event)
;;   "Pouet EVENT."
;;   (let ((event-type (cadr event)))
;;     (when (or (eq 'created event-type)
;;               (eq 'deleted event-type))
;;       (message "Event %S" event)
;;       (rm-watch "~/aggron")
;;       ;; (sleep-for 2)
;;       (add-watch "~/aggron"))))



;; (file-notify-rm-all-watches)            ;DEBUG
;; (add-watch "~/aggron")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defvar project-cache nil
  "Structured as an alist:

(dir . (f-uniquify-alist))")



(defvar project--include-all nil)


(defun project-invalidate-cache (&optional dir)
  "Remove DIR from cache.

If DIR is nil, remove all cache."
  (interactive)
  (if dir
      (delete dir project-cache)
    (setq project-cache nil)))


(defun project--normalize-dir (dir)
  "Get absolute path of the project root of DIR."
  (concat (let ((root (project-find-root dir)))
            (if root
                (cdr root)
              (message "Warning: can't normalize project dir '%s'" dir)
              (expand-file-name dir)))
          (if project--include-all "./" "")))


(defun project--find-files (dir)
  "Return all files found in DIR."
  (let ((command
         (format
          "fd -a --color never --print0 --hidden %s --exclude .git --type f . %s" ; | sort -z | uniq -z"
          (if project--include-all "--no-ignore" "")
          dir)))
    (message "Running fd in '%s'" dir)  ;DEBUG
    (split-string (shell-command-to-string command) "\0" t)))


(defun project--uniquify-alist (dir path-list)
  "Uniquify files PATH-LIST in DIR."
  (require 'f)
  (let ((ufile-alist (f-uniquify-alist path-list))
        (short-dir (directory-file-name
                    (replace-regexp-in-string (expand-file-name "~") "~" dir))))
    (dolist (con ufile-alist)
      (setcdr con (concat (cdr con) "  --  " short-dir)))
    ufile-alist))


(defun project--populate-cache (dir)
  "Add a cons (DIR . f-uniquify-alist) to cache."
  (let* ((ufile-alist (project--uniquify-alist dir (project--find-files dir)))
         (new-entry (cons dir ufile-alist)))
    (add-to-list 'project-cache new-entry)
    new-entry))


(defun project--get-cached-or-populate (dir)
  "Get DIR from cache, or populate it if nil."
  (let* ((normalized-dir (project--normalize-dir dir))
         (cached (assoc normalized-dir project-cache)))
    (if cached cached
      (project--populate-cache normalized-dir))))


(defun project--get-files-or-populate (dir)
  "Get DIR files from cache, or populate it if nil."
  (mapcar #'car (cdr (project--get-cached-or-populate dir))))


(defun project--get-ufiles-or-populate (dir)
  "Get DIR uniquified files from cache, or populate it if nil."
  (mapcar #'cdr (cdr (project--get-cached-or-populate dir))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun project--find-uniquified-file-in-project (ufile project)
  "Find a uniquified file UFILE in the given PROJECT."
  (car (rassoc ufile (cdr (project--get-cached-or-populate project)))))


(defun project--find-uniquified-file (ufile &optional project)
  "Find a uniquified file UFILE in the given PROJECT.

If PROJECT is nil, assume all projects."
  (if project
      (project--find-uniquified-file-in-project ufile project)
    (car (remove nil
                 (mapcar (lambda (proj)
                           (project--find-uniquified-file-in-project ufile proj))
                         (project-known-project-roots)))))) ;TODO


(defun project--uniquify-files (prompt
                                all-files &optional predicate
                                hist mb-default)
  "ZBOUB"
  ;; TODO: prompt
  (let* ((first-file-proj (project--normalize-dir (car all-files)))
         (last-file-proj (project--normalize-dir (car (last all-files))))
         (ufile-list nil)
         (proj nil)
         (selected-file nil))
    (if (string= first-file-proj last-file-proj)
        ;; there's only 1 project queried
        (progn
          (setq proj first-file-proj)
          (setq ufile-list (project--get-ufiles-or-populate proj)))
      ;; multiples projects, assume ALL projects
      (setq ufile-list (mapcan #'project--get-ufiles-or-populate
                               (project-known-project-roots))))
    (setq selected-file (project--completing-read-strict
                         prompt
                         (project--file-completion-table ufile-list)
                         predicate
                         hist mb-default))
    (project--find-uniquified-file selected-file proj)))

(setq project-read-file-name-function 'project--uniquify-files)


(cl-defmethod project-files (_project &optional dirs)
  "Override `project-files' to use `fd' in local PROJECT / DIRS."
  (mapcan #'project--get-files-or-populate
          (delete-dups dirs)))


(defun find-file-in-all-projects (&optional include-all)
  "Visit a file (with completion) in *all* projects.

The filename at point (determined by `thing-at-point'), if any,
is available as part of \"future history\".

If INCLUDE-ALL is non-nil, or with prefix argument when called
interactively, include all files under the project root, except
for VCS directories listed in `vc-directory-exclusion-list'."
  (interactive "P")
  (project-find-file-in (thing-at-point 'filename)
                        (project-known-project-roots)
                        ;; (project-try-vc "~/config-files")
                        ;; (project-current t)
                        (cons 'transient (expand-file-name "~/config-files"))
                        include-all))


(defun better--project-find-file-in (_fun &rest args)
  "Zboub FUN ARGS."
  (let* ((suggested-filename (pop args))
        (dirs (pop args))
        (project (pop args)))
    (setq project--include-all (pop args))
    (let* ((all-files (project-files project dirs))
           (completion-ignore-case read-file-name-completion-ignore-case)
           (file (funcall project-read-file-name-function
                          "Find file" all-files nil 'file-name-history
                          suggested-filename)))
      (if (string= file "")
          (user-error "You didn't specify the file")
        (find-file file)))))

(advice-add 'project-find-file-in :around #'better--project-find-file-in)


(defun project--annotate-file (cand)
  "Fix marginalia-annotate-project-file for CAND."
  (marginalia-annotate-project-file
   (if (or (file-exists-p cand)
           (string= cand "... (choose a dir)"))
       cand
     (or (project--find-uniquified-file-in-project cand (cdr (project-current)))
         (project--find-uniquified-file cand)))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun magit-project-full ()
  "Git status with magit on the project -- entire window."
  (interactive)
  (magit-project-status)
  (delete-other-windows))


(defcustom project-root-markers
  '("compile_commands.json" ".git")
  "Files or directories that indicate the root of a project."
  :type '(repeat string)
  :group 'project)

(defun project-root-p (path)
  "Check if the current PATH has any of the project root markers."
  (catch 'found
    (dolist (marker project-root-markers)
      (when (file-exists-p (concat path "/" marker))
        (throw 'found marker)))))

(defun project-find-root (path)
  "Search up the PATH for `project-root-markers'."
  (when-let ((root (locate-dominating-file path #'project-root-p)))
    (cons 'transient (expand-file-name root))))



(defun project-save-some-buffers (&optional arg)
  "Save some modified file-visiting buffers in the current project.

Optional argument ARG (interactively, prefix argument) non-nil
means save all with no questions."
  (interactive "P")
  (let* ((project-buffers (project-buffers (project-current)))
         (pred (lambda () (memq (current-buffer) project-buffers))))
    (funcall-interactively #'save-some-buffers arg pred)))

(define-advice project-compile (:around (fn) save-project-buffers)
  "Only ask to save project-related buffers."
  (let* ((project-buffers (project-buffers (project-current)))
         (compilation-save-buffers-predicate
          (lambda () (memq (current-buffer) project-buffers))))
    (funcall fn)))

(define-advice recompile (:around (fn &optional edit-command) save-project-buffers)
  "Only ask to save project-related buffers if inside a project."
  (if (project-current)
      (let* ((project-buffers (project-buffers (project-current)))
             (compilation-save-buffers-predicate
              (lambda () (memq (current-buffer) project-buffers))))
        (funcall fn edit-command))
    (funcall fn edit-command)))



(provide 'init-project)
;;; init-project.el ends here
