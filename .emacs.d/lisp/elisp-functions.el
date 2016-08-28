;;; elisp-functions.el --- misc functions
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    elisp-functions.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/15 15:31:23 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/28 16:39:06 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(defun k-thx-bye ()
  "Exit server and save desktop."
  (interactive)
  (when (y-or-n-p "Save Desktop? ")
    (desktop-save "~/.emacs.d/misc"))
  (save-buffers-kill-terminal)
  (kill-emacs))


(defun insert-eol ()
  "Insert a pretty \\n !"
  (interactive)
  (insert "\n"))

(defun toggle-macro ()
  "Toggle macro recording."
  (interactive)
  (if (null defining-kbd-macro)
      (kmacro-start-macro nil) (kmacro-end-macro nil)))

(defun dired-find-files (&optional arg)
  "Open each of the marked files, or the file under the point, or when prefix ARG, the next N files."
  (interactive "P")
  (let* ((fn-list (dired-get-marked-files nil arg)))
    (mapc 'find-file fn-list)))

(defun vc-dir-find-files (&optional arg)
  "Open each of the marked files, or the file under the point, or when prefix ARG, the next N files."
  (interactive "P")
  (let* ((fn-list (vc-dir-marked-files)))
    (mapc 'find-file fn-list)))

(defun tags-make-n-visit (file-pattern)
  "Create a tag file corresponding to FILE-PATTERN, then visit it."
  (interactive
   (list (read-from-minibuffer
          (concat "tag pattern (default " (nth 0 tags-make-n-visit-history) "): ")
          nil nil nil 'tags-make-n-visit-history)))
  (shell-command (concat "etags -o ~/.emacs.d/misc/TAGS "
                         (if (string= "" file-pattern)
                             (nth 0 tags-make-n-visit-history)
                           file-pattern)))
  (visit-tags-table "~/.emacs.d/misc/TAGS"))

(defun copy-killring-to-clipboard()
  "Copy killring to clipboard!"
  (interactive)
  (shell-command (concat "xsel -ib << EOF \n" (car kill-ring)))
  (message "Kill-ring copied to clipboard!"))

(defun par()
  "par"
  (interactive)
  (insert "()")
  (backward-char 1))

(defun cro()
  "cro"
  (interactive)
  (insert "[]")
  (backward-char 1))

(defun aco()
  "ac"
  (interactive)
  (move-end-of-line 1)
  (insert "\n{")
  (indent-for-tab-command)
  (insert "\n\n}")
  (indent-for-tab-command)
  (previous-line 1)
  (indent-for-tab-command))

(defun guigui()
  "guigui"
  (interactive)
  (insert "\"\"")
  (backward-char 1))

(defun gui()
  "gui"
  (interactive)
  (insert "\'\'")
  (backward-char 1))

(defun inc()
  "inc"
  (interactive)
  (insert "<>")
  (backward-char 1))

(defun mainarg()
  "main"
  (interactive)
  (insert "int\t\tmain(int ac, char **av)\n{\n\t\n\treturn (0);\n}\n")
  (previous-line 3)
  (forward-char 1))

(defun main()
  "main"
  (interactive)
  (insert "int\t\tmain(void)\n{\n\t\n\treturn (0);\n}\n")
  (previous-line 3)
  (forward-char 1))

(defun semi-c ()
  "Semi-colon at end of line, without moving!"
  (interactive)
  (point-to-register 'm)
  (move-end-of-line nil)
  (insert ";")
  (jump-to-register 'm))

(defun normdown()
  "normdown"
  (interactive)
  (next-line 24))

(defun normup()
  "normup"
  (interactive)
  (previous-line 24))

(defun headcomment()
  "head comment"
  (interactive)
  (newline)
  (insert "/*")
  (newline)
  (insert "** ")
  (newline)
  (insert "*/")
  (previous-line 2)
  (forward-char 4))

(defun comment()
  "comment"
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (or (not transient-mark-mode) (region-active-p))
      (setq start (save-excursion
                    (goto-char (region-beginning))
                    (beginning-of-line)
                    (point))
            end (save-excursion
                  (goto-char (region-end))
                  (end-of-line)
                  (point))))
    (comment-or-uncomment-region start end)))

(defun insert-debug-comment()
  "Insert a 'debug' comment."
  (interactive)
  (point-to-register 'm)
  (comment-dwim nil)
  (insert "debug")
  (jump-to-register 'm))



(defun indent-buffer ()
  "Indent an entire buffer using the default intenting scheme."
  (interactive)
  (point-to-register 's)
  (goto-line 12)
  (point-to-register 'o)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) ())
  (jump-to-register 'o)
  (replace-regexp "\\(\tint\\)\\([^\t]\\)" "\\1\t\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\nint\\)\\([^\t]\\)" "\\1\t\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\tchar\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\nchar\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\tvoid\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\nvoid\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\tdouble\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\ndouble\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\tfloat\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\nfloat\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\tshort\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\nshort\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\tlong\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\nlong\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\tsize_t\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(\nsize_t\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static int\\)\\([^\t]\\)" "\\1\t\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static char\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static void\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static double\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static float\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static short\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static long\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-regexp "\\(static size_t\\)\\([^\t]\\)" "\\1\t\\2")
  (jump-to-register 'o)
  (replace-string " \n" "\n")
  (jump-to-register 'o)
  (replace-string "  \n" "\n")
  (jump-to-register 'o)
  (replace-string "   \n" "\n")
  (jump-to-register 'o)
  (replace-string "    \n" "\n")
  (jump-to-register 'o)
  (replace-string "    " "\t")
  (jump-to-register 'o)
  (replace-string "   " "\t")
  (jump-to-register 'o)
  (replace-string "  " "\t")
  (jump-to-register 'o)
  (replace-string "\t\n" "\n")
  (jump-to-register 'o)
  (replace-string "\t\t\n" "\n")
  (jump-to-register 'o)
  (replace-string "\t " "\t")
  (jump-to-register 'o)
  (replace-string " \t" "\t")
  (jump-to-register 'o)
  (replace-string "int\t " "int\t\t")
  (jump-to-register 'o)
  (replace-string "static void " "static void\t")
  (jump-to-register 'o)
  (replace-string "static char " "static char\t")
  (jump-to-register 'o)
  (replace-string "static int " "static int\t")
  (jump-to-register 'o)
  (replace-string "static double " "static double\t")
  (jump-to-register 'o)
  (replace-string "static t_lst " "static t_lst\t")
  (jump-to-register 'o)
  (replace-string "static t_list " "static t_list\t")
  (jump-to-register 'o)
  (replace-string "static t_bool " "static t_bool\t")
  (jump-to-register 'o)
  (replace-string "static size_t " "static size_t\t")
  (jump-to-register 'o)
  (replace-string "static short " "static short\t")
  (jump-to-register 'o)
  (replace-string "static float " "static float\t")
  (jump-to-register 'o)
  (replace-string "static long " "static long\t")
  (jump-to-register 'o)
  (replace-string "\nvoid " "\nvoid\t")
  (jump-to-register 'o)
  (replace-string "\nchar " "\nchar\t")
  (jump-to-register 'o)
  (replace-string "\nint " "\nint\t")
  (jump-to-register 'o)
  (replace-string "\ndouble " "\ndouble\t")
  (jump-to-register 'o)
  (replace-string "\nt_lst " "\nt_lst\t")
  (jump-to-register 'o)
  (replace-string "\nt_list " "\nt_list\t")
  (jump-to-register 'o)
  (replace-string "\nt_bool " "\nt_bool\t")
  (jump-to-register 'o)
  (replace-string "\nsize_t " "\nsize_t\t")
  (jump-to-register 'o)
  (replace-string "\nfloat " "\nfloat\t")
  (jump-to-register 'o)
  (replace-string "\nshort " "\nshort\t")
  (jump-to-register 'o)
  (replace-string "\nlong " "\nlong\t")
  (jump-to-register 'o)
  (replace-string " ;" ";")
  (jump-to-register 'o)
  (replace-string "break;" "break ;")
  (jump-to-register 'o)
  (replace-string "continue;" "continue ;")
  (jump-to-register 'o)
  (replace-string "return;" "return ;")
  (jump-to-register 'o)
  (replace-string "return(" "return (")
  (jump-to-register 'o)
  (replace-string "if(" "if (")
  (jump-to-register 'o)
  (replace-string "while(" "while (")
  (jump-to-register 'o)
  (replace-string "\n\n\n" "\n\n")
  (jump-to-register 'o)
  (replace-string "\n\n\n" "\n\n")
  (jump-to-register 'o)
  (replace-string "\n\n\n\n" "\n\n")
  (jump-to-register 'o)
  (replace-string "\n\n\n\n\n" "\n\n")
  (jump-to-register 's)
  ;; (require 'whitespace)
  ;; (setq whitespace-auto-cleanup t)
  ;; (whitespace-global-mode 1)
  )

(provide 'elisp-functions)
;;; elisp-functions.el ends here
