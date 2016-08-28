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
;    Updated: 2016/08/29 00:00:09 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(use-package cc-mode
  :mode
  ("\\.tpp$" . c++-mode)

  :config
  (add-hook 'c-mode-hook
            (lambda ()
              (highlight-regexp "\t ")
              (highlight-regexp " \t")
              (highlight-regexp "if(")
              (highlight-regexp "while(")
              (highlight-regexp "return(")
              ;; (highlight-regexp "return;")
              ;; (highlight-regexp "break;")
              ;; (highlight-regexp "continue;")
              ;; (highlight-regexp "\n\n\n+")
              ;; (highlight-lines-matching-regexp ".\\{81\\}" 'hi-red-b)
              ;; (highlight-regexp "{\n\\(.*\n\\)\\{26,\\}}\n\\(\n\\|\\'\\)" 'hi-red-b)
              ;; (highlight-phrase "^[^#/].*  +")
              ;; (highlight-regexp "\[([\][[:space:]]")
              ;; (highlight-regexp "[[:space:]]\[])\]")


              ;; indentation fix (struct/switch)
              (c-set-offset 'case-label '+)
              (setq indent-tabs-mode t)))
  
  (add-hook 'c++-mode-hook
            (lambda ()
              (c-set-offset 'inclass '++)
              (local-unset-key (kbd "M-q")) ;TODO
              ;; (local-set-key (kbd "M-h") 'hpp-template) ; -> elisp-functions.el
              ;; (local-set-key (kbd "M-c") 'cpp-template) ; -> elisp-functions.el
              ;; (local-set-key (kbd "M-c") 'cpp-get-set-template) ; -> elisp-functions.el
              ;; (local-set-key (kbd "M-h") 'hpp-get-set-template)) ; -> elisp-functions.el
              )))

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


(provide 'init-cc-mode)
;;; init-cc-mode.el ends here
