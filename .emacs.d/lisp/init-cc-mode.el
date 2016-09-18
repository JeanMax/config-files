;;; init-cc-mode.el --- init cc-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-cc-mode.el                                     :+:      :+:    :+:   ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2016/09/18 13:14:10 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package cc-mode
  :mode
  ("\\.tpp$" . c++-mode)

  :config
  (setq-default c-basic-offset 4)
  (setq-default c-default-style "linux")

  (add-hook 'c++-mode-hook
            (lambda ()
              (c-set-offset 'inclass '++))))
              ;; (local-unset-key (kbd "M-q") ;TODO
              ;; (local-set-key (kbd "M-h") 'hpp-template) ; -> elisp-functions.el
              ;; (local-set-key (kbd "M-c") 'cpp-template) ; -> elisp-functions.el
              ;; (local-set-key (kbd "M-c") 'cpp-get-set-template) ; -> elisp-functions.el
              ;; (local-set-key (kbd "M-h") 'hpp-get-set-template)) ; -> elisp-functions.el


(bind-key* (kbd "C-c C-g") 'headcomment)
(bind-key* (kbd "M-è") 'main) ; 7
(bind-key* (kbd "M-;") 'semi-c)
(bind-key* (kbd "C-i") 'indent-buffer)
;; (bind-key* (kbd "C-c M-c") 'stuff)

;; (defun hpp-template(class)
  ;;   "hpp-template"
  ;;   (interactive "sClass name? ")
  ;;   (insert-hpp-template)
  ;;   (replace-string "zz" class))

  ;; (defun cpp-template(class)
  ;;   "cpp-template"
  ;;   (interactive "sClass name? ")
  ;;   (insert-cpp-template)
  ;;   (replace-string "zz" class))

  ;; (defun insert-hpp-template()
  ;;   "insert-hpp-template"
  ;;   (interactive)
  ;;   (header-insert)
  ;;   (goto-line 12)
  ;;   ;; (insert "\n#ifndef ZZ_HPP\n\n")
  ;;   (insert "\n#ifndef ZZ_CLASS_HPP\n\n")
  ;;   (insert "/*\n** defines\n*/\n")
  ;;   ;; (insert "# define ZZ_HPP\n\n")
  ;;   (insert "# define ZZ_CLASS_HPP\n\n")
  ;;   (insert "/*\n** includes\n*/\n")
  ;;   (insert "//# include <iostream>\n\n")
  ;;   (insert "/*\n** class\n*/\n")
  ;;   (insert "class Zz\n{\n")
  ;;   (insert "\tpublic:\n")
  ;;   (insert "\t\tZz(void);\n")
  ;;   (insert "\t\tZz(Zz const &copy);\n")
  ;;   (insert "\t\t~Zz(void);\n")
  ;;   (insert "\t\tZz\t\t&operator=(Zz const &copy);\n\n")
  ;;   (insert "\tprotected:\n\n")
  ;;   (insert "};\n\n")
  ;;   ;; (insert "#endif //ZZ_HPP")
  ;;   (insert "#endif //ZZ_CLASS_HPP")
  ;;   (goto-line 12))

  ;; (defun insert-cpp-template()
  ;;   "insert-cpp-template"
  ;;   (interactive)
  ;;   (header-insert)
  ;;   (goto-line 12)
  ;;   ;; (insert "\n#include \"Zz.hpp\"\n\n")
  ;;   (insert "\n#include \"Zz.class.hpp\"\n\n")
  ;;   (insert "/*\n** constructor\n*/\n")
  ;;   (insert "Zz::Zz(void)\n{\n\n}\n\n")
  ;;   (insert "Zz::Zz(Zz const &copy)\n{\n")
  ;;   (insert "\t*this = copy;\n}\n\n")
  ;;   (insert "/*\n** destructor\n*/\n")
  ;;   (insert "Zz::~Zz(void)\n{\n\n}\n\n")
  ;;   (insert "/*\n** operator overload\n*/\n")
  ;;   (insert "Zz\t\t\t\t\t&Zz::operator=(Zz const &copy)\n{\n")
  ;;   (insert "\t//this->_z = copy._z;\n\n\treturn *this;\n}\n\n")
  ;;   (insert "/*\n** public\n*/\n")
  ;;   (insert "\n\n")
  ;;   (insert "/*\n** getter/setter\n*/\n")
  ;;   (insert "\n\n")
  ;;   (insert "/*\n** protected\n*/\n")
  ;;   (insert "\n\n")
  ;;   (insert "")
  ;;   (goto-line 12))

  ;; (defun hpp-get-set-template(type var)
  ;;   "hpp-get-set-template"
  ;;   (interactive "stype? \nsvar name? ")
  ;;   (point-to-register 'p)
  ;;   (insert "yyy\t\t_zzz;\n")
  ;;   (insert "yyy\t\tgetZzz\(void\)\tconst;\n")
  ;;   (insert "void\t\tsetZzz\(yyy zzz\);\n")
  ;;   (goto-line 12)
  ;;   (replace-string "yyy" type)
  ;;   (goto-line 12)
  ;;   (replace-string "int\t\t_zzz" "int\t\t\t_zzz")
  ;;   (goto-line 12)
  ;;   (replace-string "int\t\tget_zzz" "int\t\t\tget_zzz")
  ;;   (goto-line 12)
  ;;   (replace-string "zzz" var)
  ;;   (indent-buffer)
  ;;   (jump-to-register 'p))

  ;; (defun cpp-get-set-template(type var class)
  ;;   "cpp-get-set-template"
  ;;   (interactive "stype? \nsvar name? \nsclass name? ")
  ;;   (point-to-register 'p)
  ;;   (insert "yyy\t\t\tXxx::getZzz(void)\tconst\t{ return this->_zzz; }\n")
  ;;   (insert "void\t\t\tXxx::setZzz(yyy zzz)\t\t{ this->_zzz = zzz; }\n")
  ;;   (goto-line 12)
  ;;   (replace-string "yyy" type)
  ;;   (goto-line 12)
  ;;   (replace-string "int\t\t\tXxx" "int\t\t\t\tXxx")
  ;;   (goto-line 12)
  ;;   (replace-string "zzz" var)
  ;;   (goto-line 12)
  ;;   (replace-string "xxx" class)
  ;;   (indent-buffer)
  ;;   (jump-to-register 'p))

  ;; (defun stuff (class)
  ;;   "Stuffs with CLASS."
  ;;   (interactive "sClass name? ")
  ;;   ;; (find-file-other-window (concat class ".cpp"))
  ;;   (find-file-other-window (concat class ".class.cpp"))
  ;;   (insert-cpp-template)
  ;;   (replace-string "zz" class)
  ;;   (save-buffer)
  ;;   (delete-window)
  ;;   ;; (find-file-other-window (concat class ".hpp"))
  ;;   (find-file-other-window (concat class ".class.hpp"))
  ;;   (insert-hpp-template)
  ;;   (replace-string "zz" class)
  ;;   (save-buffer)
  ;;   (delete-window)
  ;;   (shell-command "ls")))

(defun main ()
  "main"
  (interactive)
  (insert "int\t\tmain(int ac, char **av, char **env)\n{\n\t\n\treturn (EXIT_SUCCESS);\n}\n")
  (previous-line 3)
  (forward-char 1))

(defun semi-c ()
  "Semi-colon at end of line, without moving!"
  (interactive)
  (point-to-register 'm)
  (move-end-of-line nil)
  (insert ";")
  (jump-to-register 'm))

(defun headcomment ()
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

(provide 'init-cc-mode)
;;; init-cc-mode.el ends here
