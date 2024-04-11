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

;;; Code:
(use-package project
  :bind-keymap ("£" . project-prefix-map)
  :bind (:map project-prefix-map
         ("v" . 'magit-project-full)
         ("f" . 'project-find-file)
         ("F" . 'find-file-in-all-projects)
         ("E" . 'project-or-external-find-file))
  :init
  (setq project-vc-merge-submodules t)
  (setq project-switch-use-entire-map t)
  (setq project-switch-commands
        '((project-find-file "Find file" nil)
          (project-find-regexp "Find regexp" nil)
          (project-find-dir "Find directory" nil)
          (magit-project-status "Magit" 109)
          (mistty-in-project "Shell" nil)
          (project-compile "Compile" nil)
          (project-kill-buffers "Kill" nil))))


;; (define-advice project-find-file (:around (old-fn))
;;   "Set `find-program' back to find."
;;   (let ((find-program "find"))
;;     (call-interactively old-fn)))

;; (setq find-program "fd --color never")



(cl-defmethod project-files (project &optional dirs)
  "Override `project-files' to use `fd' in local PROJECT / DIRS."
  (let* ((paths (mapconcat 'identity dirs " "))
         (command (format
                   "fd --color never --print0 --hidden --exclude .git --type f . %s | sort -z | uniq -z"
                   paths)))
    ;; (message command)                   ;DEBUG
    ;; seems resorted afterward... probably by orderless / vertico
    ;; (sort (delete-dups
           (split-string (shell-command-to-string command) "\0" t)
           ;; ) #'string<)
    ))



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
                        (cons 'transient "~/config-files")
                        include-all))

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
      (when (file-exists-p (concat path marker))
        (throw 'found marker)))))

(defun project-find-root (path)
  "Search up the PATH for `project-root-markers'."
  (when-let ((root (locate-dominating-file path #'project-root-p)))
    (cons 'transient (expand-file-name root))))
(add-to-list 'project-find-functions #'project-find-root)



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
