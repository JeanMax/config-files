;*******************************************************************************;
;                                                                               ;
;                                                          :::      ::::::::    ;
;    dotemacs                                            :+:      :+:    :+:    ;
;                                                      +:+ +:+         +:+      ;
;    by: thor <thor@42.fr>                           +#+  +:+       +#+         ;
;                                                  +#+#+#+#+#+   +#+            ;
;    Created: 2013/06/18 14:01:14 by thor               #+#    #+#              ;
;    Updated: 2015/01/28 23:46:18 by mcanal           ###   ########.fr        ;
;                                                                               ;
;*******************************************************************************;

; Load general features files
(setq config_files "~/emacs_stuff/site-lisp/")
(setq load-path (append (list nil config_files) load-path))

(load "list.el")
(load "string.el")
(load "comments.el")
(load "header.el")

; Set default emacs configuration
(set-language-environment "UTF-8")
(setq-default font-lock-global-modes nil)
(setq-default line-number-mode nil)
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                             64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

; Load user configuration
(if (file-exists-p "~/.myemacs") (load-file "~/.myemacs"))

; Custom adds
(column-number-mode 1)
(line-number-mode 1)
(global-set-key [(meta g)] 'goto-line)
(global-set-key [(insertchar)] 'set-mark-command)
(global-set-key [(backtab)] 'dabbrev-expand)
(global-set-key (kbd "œ") 'tab-to-tab-stop)
(global-set-key (kbd "<f2>") 'kill-region)
(global-set-key (kbd "<f3>") 'kill-ring-save)
(global-set-key (kbd "<f4>") 'yank)
(global-set-key (kbd "<C-f4>") 'yank-pop)
(global-set-key (kbd "<f5>") 'kill-line)
(global-set-key (kbd "<C-f5>") 'kill-paragraph)
(global-set-key [(f6)] 'backward-kill-word)
(global-set-key (kbd "<C-f6>") 'backward-delete-char)
(global-set-key [(f7)] 'kill-word)
(global-set-key (kbd "<C-f7>") 'delete-char)
(global-set-key [(f8)] 'undo)
(global-set-key [(f9)] 'isearch-forward)
(global-set-key (kbd "<C-f9>") 'transpose-chars)
(global-set-key [(f10)] 'query-replace)
(global-set-key (kbd "<C-f10>") 'transpose-words)
(global-set-key [(f11)] 'save-buffer)
(global-set-key (kbd "<C-f11>") 'transpose-lines)
(global-set-key [(f12)] 'save-buffers-kill-emacs)
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "M-u") 'backward-word)
(global-set-key (kbd "M-o") 'forward-word)
(global-set-key (kbd "M-_") 'move-beginning-of-line)
(global-set-key (kbd "M-ç") 'move-end-of-line)
(setq backup-directory-alist (list (cons "." "~/emacsbackups/")))
(transient-mark-mode t)
(setq make-backup-files nil)

(defun par()
  "par"
  (interactive)
  (insert "(")
  (insert ")")
  (backward-char 1)
)
(global-set-key (kbd "M-&") 'par)

(defun cro()
  "cro"
  (interactive)
  (insert "[")
  (insert "]")
  (backward-char 1)
)
(global-set-key (kbd "M-é") 'cro)

(defun ac()
  "ac"
  (interactive)
  (newline)
  (insert "{")
  (newline)
  (c-indent-command)
  (newline)
  (insert "}")
  (previous-line 1)
)
(global-set-key (kbd "M-\"") 'ac)

(defun guigui()
  "guigui"
  (interactive)
  (insert "\"")
  (insert "\"")
  (backward-char 1)
)
(global-set-key (kbd "M-\'") 'guigui)

(defun gui()
  "gui"
  (interactive)
  (insert "\'")
  (insert "\'")
  (backward-char 1)
)
(global-set-key (kbd "M-(") 'gui)

(defun main()
  "main"
  (interactive)
  (insert "int\t\tmain(int ac, char **av)\n{\n\t\n\treturn (0);\n}\n")
  (previous-line 3)
  (forward-char 1)
)
(global-set-key (kbd "M--") 'main)

(defun normdown()
  "normdown"
  (interactive)
  (next-line 25)
)
(global-set-key (kbd "M-m") 'normdown)


(defun normup()
  "normup"
  (interactive)
  (previous-line 25)
)
(global-set-key (kbd "M-p") 'normup)


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
  (forward-char 4)  
)
(global-set-key "\C-c\C-g" 'headcomment)

(defun comment()
  "comment"
  (interactive)
  (insert "//")
  (backward-char 2)
)
(global-set-key "\M-q" 'comment)

(defun debug()
  "debug"
  (interactive)
  (insert " //debug")
  (backward-char 8)
)
(global-set-key "\C-q" 'debug)


(defun indent-buffer ()
  "Indents an entire buffer using the default intenting scheme."
  (interactive)
  (point-to-register 's)
  (goto-line 12)
  (point-to-register 'o)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
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
  (replace-string "\tint " "\tint\t")
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
)
(global-set-key "\C-g" 'indent-buffer)  
;*******************************************************************************;
