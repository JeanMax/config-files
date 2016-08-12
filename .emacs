
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    .emacs                                             :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/11 13:15:47 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;external config
;; (setq config_files "~/emacs_stuff/site-lisp/")
;; (setq config_files "~/.emacs.d/stuff")
;; (setq load-path (append (list nil config_files) load-path))

;;; Code:
(setq load-path (append (list nil "~/.emacs.d/stuff") load-path))

(require 'list)
(require 'string)
(require 'comments)
;; (require 'header)
(require 'bind-key)
(require 'highlight-chars)
;; (require 'yasnippet)
(require 'auto-complete)
(require 'auto-complete-config)
;; (require 'scala-mode2)
;; (require 'tuareg)
(require 'web-mode)
(require 'php-mode)
(require 'highlight-indent-guides)
(require 'rx)

;(require 'fuzzy)
;(require 'popup)
;(require 'flyspell)
;(require 'auto-complete-c-headers)

(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;(add-to-list 'package-archives
  ;;           '("mepla" . "http://melpa.org/packages/") t)
(package-initialize)

;; (global-flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)


;;IMPORTANT stuff
(setq tetris-score-file "~/.emacs.d/tetris-scores")
(setq tetris-score-file "~/.emacs.d/snake-scores")

;encoding
(set-language-environment "UTF-8")

;extensions handling
;(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.jvm\\'" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.ml\\'" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.mli\\'" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;indentation
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;del key workaround
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)

;color
(set-face-foreground 'font-lock-string-face "#E6C28F")
(set-face-foreground 'font-lock-function-name-face "royal blue")
(set-face-foreground 'font-lock-variable-name-face "orange")
(set-face-foreground 'font-lock-builtin-face "magenta")

;col/line number
(column-number-mode 1)
(setq linum-format "%3d ")

;backup
(setq backup-directory-alist `((".*" . ,"~/.emacs.d/backup")))
(setq auto-save-file-name-transforms `((".*" ,"~/.emacs.d/backup" t)))
(setq kept-new-versions 42)
(setq kept-old-versions 42)
(setq version-control t)

;C hook
(add-hook 'c-mode-hook
		  (lambda()
			;highlighting
			(hc-highlight-trailing-whitespace)
			;; (highlight-lines-matching-regexp ".\\{81\\}" 'hi-red-b)
			;; (highlight-regexp "{\n\\(.*\n\\)\\{26,\\}}\n\\(\n\\|\\'\\)" 'hi-red-b)

			;; (highlight-phrase "^[^#/].*  +")
			;; (highlight-regexp "\[([\][[:space:]]")
			;; (highlight-regexp "[[:space:]]\[])\]")

			(highlight-regexp "\t ")
			(highlight-regexp " \t")
			(highlight-regexp "if(")
			(highlight-regexp "while(")
			(highlight-regexp "return(")
			;; (highlight-regexp "return;")
			;; (highlight-regexp "break;")
			;; (highlight-regexp "continue;")
			;; (highlight-regexp "\n\n\n+")
			

			;indentation fix (struct/switch)
			(c-set-offset 'inclass '+) ;++ me for c++ only please :O
			(c-set-offset 'case-label '+)
		  )
)

;web hook
(defun my-web-mode-hook ()
  "Hooks for Web mode."
 (set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "green")
 (set-face-attribute 'web-mode-html-tag-face nil :foreground "green")
 (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "yellow")
 (set-face-attribute 'web-mode-html-attr-value-face nil :foreground "firebrick2")
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

;;erc
(setq erc-save-buffer-on-part t)
(setq erc-autojoin-channels-alist
  '((".*\\.freenode.net" "#emacs" "#trisquel")
	(".*\\.synirc.net" "#d2bs")))
(setq erc-keywords '("jean" "smurf"))
(erc-match-mode)

(defun ercs ()
  "Connect to IRC."
  (interactive)
  (when (y-or-n-p "Freenode? ")
    (erc :server "irc.freenode.net" :port 6667 :nick "JeanMax"))
  (when (y-or-n-p "Synirc? ")
    (erc :server "irc.synirc.net" :port 6667 :nick "Smurf")))


;ibuffer
(setq ibuffer-saved-filter-groups
	   '(("home"
			("mail" (or
                            (mode . message-mode)
                            (mode . bbdb-mode)
                            (mode . mail-mode)
                            (mode . gnus-group-mode)
                            (mode . gnus-summary-mode)
                            (mode . gnus-article-mode)
                            (name . "^\\.bbdb$")
                            (name . "^\\.newsrc-dribble")))
			("irc" (mode . erc-mode))
			("*.*" (name . "^\*.*\*$"))
			("dir" (mode . dired-mode)))))
(add-hook 'ibuffer-mode-hook
		    '(lambda ()
			        (ibuffer-switch-to-saved-filter-groups "home")))
(setq ibuffer-expert t)
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


;gnus (account infos in .authinfo)
(setq gnus-select-method
      '(nnimap "gmail"
			          (nnimap-address "imap.gmail.com")
					         (nnimap-server-port "imaps")
							        (nnimap-stream ssl)))
(setq smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")


;window splitting at launch
(setq split-height-threshold 25)
(setq split-width-threshold 80)

;completion
(ac-config-default)
(set-default 'ac-sources
			 '(
			   ac-source-dictionary
			   ac-source-words-in-same-mode-buffers
			   ))
(setq ac-delay 0)              ;; 0.1
(setq ac-auto-show-menu 0.4)     ;; 0.8
(setq ac-fuzzy-cursor-color 'color-160)
(add-hook 'auto-complete-mode-hook
          (lambda()
	    (setq ac-use-menu-map t)
	    (local-set-key [(backtab)] 'auto-complete)
	    (define-key ac-menu-map [(next)] 'ac-next)
	    (define-key ac-menu-map [(prior)] 'ac-previous)
		(define-key ac-completing-map [down] nil)
		(define-key ac-completing-map [up] nil)
	    ))

;; git status in dired mode
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(setq diff-hl-mode t)


;selecting region with shift
(transient-mark-mode t) ;??

;hide/show mod
(add-hook 'prog-mode-hook #'hs-minor-mode)


;; Customizing colors used in diff mode
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-overstrike ((t (:inherit bold :foreground "brightred"))))
 '(Man-underline ((t (:inherit bold :foreground "brightgreen"))))
 '(diff-added ((t (:foreground "green"))))
 '(diff-changed ((t (:foreground "purple"))))
 '(diff-hl-change ((t (:background "color-130" :foreground "white"))))
 '(diff-hl-dired-change ((t (:inherit diff-hl-change :foreground "red"))))
 '(diff-removed ((t (:foreground "red"))))
 '(highlight-indent-guides-character-face ((t (:foreground "color-241"))))
 '(match ((t (:inherit bold :foreground "brightred"))))
 '(shr-strike-through ((t (:strike-through "red")))))


;vars
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-hl-highlight-function nil)
 '(diff-hl-margin-mode t)
 '(erc-log-channels-directory "~/.emacs.d/erc-log")
 '(erc-modules
   (quote
	(autojoin button completion fill irccontrols keep-place list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track)))
 '(erc-nick "JeanMax")
 '(erc-track-exclude-types (quote ("JOIN" "NICK" "PART" "QUIT" "MODE" "333" "353")))
 '(erc-track-mode t)
 '(eww-search-prefix
   "https://www.startpage.com/do/dsearch?cat=web&pl=opensearch&language=english&query=")
 '(flycheck-clang-include-path
   (quote
	("../../../../../../../usr/include/SDL" "../inc" "../../inc" "../libft/inc" "../../libft/inc")))
 '(flycheck-clang-warnings (quote ("all" "extra" "error")))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(highlight-indent-guides-method (quote column))
 '(ibuffer-fontification-alist
   (quote
	((10 buffer-read-only font-lock-constant-face)
	 (15
	  (and buffer-file-name
		   (string-match ibuffer-compressed-file-name-regexp buffer-file-name))
	  font-lock-doc-face)
	 (20
	  (string-match "^*"
					(buffer-name))
	  font-lock-keyword-face)
	 (25
	  (and
	   (string-match "^ "
					 (buffer-name))
	   (null buffer-file-name))
	  italic)
	 (30
	  (memq major-mode ibuffer-help-buffer-modes)
	  font-lock-comment-face)
	 (35
	  (eq major-mode
		  (quote dired-mode))
	  font-lock-function-name-face)
	 (12
	  (eq major-mode
		  (quote erc-mode))
	  font-lock-type-face))))
 '(irony-server-build-dir nil)
 '(large-file-warning-threshold nil)
 '(package-selected-packages (quote (yasnippet flylisp flycheck diff-hl company)))
 '(scala-font-lock:constant-list nil)
 '(scala-indent:step 4)
 '(woman-locale "en_US.UTF-8"))

;unbinds
(add-hook 'c++-mode-hook
          (lambda()
            (local-unset-key (kbd "M-q"))))
(global-unset-key (kbd "M-q"))
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'list-buffers 'ibuffer-other-window)

;mouse scrolling workaround
;(xterm-mouse-mode 1)
(bind-key* (kbd "<mouse-4>") 'previous-line)
(bind-key* (kbd "<mouse-5>") 'next-line)

;binds
;; (bind-key* (kbd "<C-f4>") 'yank-pop)
;; (bind-key* (kbd "<C-f5>") 'kill-paragraph)
;; (bind-key* (kbd "<C-f6>") 'backward-delete-char)
;; (bind-key* (kbd "<C-f7>") 'delete-char)
;; (bind-key* (kbd "<C-f9>") 'transpose-chars)
;; (bind-key* (kbd "<C-f10>") 'query-replace-regexp)
;; (bind-key* (kbd "<C-f11>") 'transpose-lines)
(bind-key* [(meta g)] 'goto-line)
(bind-key* [(insertchar)] 'set-mark-command)
;(bind-key* [(backtab)] 'auto-complete)
(bind-key [(backtab)] 'dabbrev-expand)
(bind-key* (kbd "ø") 'auto-complete-mode)
(bind-key* (kbd "ÿ") 'tab-to-tab-stop)
(bind-key* (kbd "<f2>") 'kill-region)
(bind-key* (kbd "<f3>") 'kill-ring-save)
(bind-key* (kbd "<f4>") 'yank)
(bind-key* (kbd "<f5>") 'kill-line)
;(bind-key* [(f6)] 'backward-kill-word)
(bind-key* [(f6)] 'point-to-register)
;(bind-key* [(f7)] 'kill-word)
(bind-key* [(f7)] 'jump-to-register)
(bind-key* [(f8)] 'undo)
(bind-key* [(f9)] 'isearch-forward)
(bind-key* [(f10)] 'query-replace)
(bind-key* [(f11)] 'save-buffer)
(bind-key* (kbd "<C-f11>") 'transpose-lines)
(bind-key* [(f12)] 'save-buffers-kill-terminal)
(bind-key* (kbd "M-i") 'previous-line)
(bind-key* (kbd "M-j") 'backward-char)
(bind-key* (kbd "M-k") 'next-line)
(bind-key* (kbd "M-l") 'forward-char)
(bind-key* (kbd "M-u") 'backward-word)
(bind-key* (kbd "M-o") 'forward-word)
(bind-key* (kbd "M-_") 'move-beginning-of-line)
(bind-key* (kbd "M-ç") 'move-end-of-line)
(bind-key* (kbd "M-m") 'normdown) ;custom
(bind-key* (kbd "M-p") 'normup) ;custom
(bind-key* (kbd "M-;") 'semi-c)
(bind-key* (kbd "C-c M-c") 'stuff)
(bind-key* (kbd "<M-prior>") 'previous-multiframe-window)
(bind-key* (kbd "<M-next>") 'next-multiframe-window)
(bind-key* (kbd "<M-insert>") 'find-file-other-window)
(bind-key* (kbd "<M-delete>") 'delete-window)
(bind-key* (kbd "<M-up>") 'global-linum-mode)
(bind-key* (kbd "<M-down>")  'hs-toggle-hiding)
(bind-key* (kbd "<M-left>") 'hs-hide-all)
(bind-key* (kbd "<M-right>")  'hs-show-all)
(bind-key* (kbd "M-s") 'shell-that)
(bind-key* (kbd "C-f") 'isearch-forward)
(bind-key* (kbd "M-f") 'find-name-dired)
(bind-key* (kbd "C-r") 'query-replace)
(bind-key* (kbd "M-r") 'query-replace-regexp)
(bind-key* (kbd "C-t") 'occur)
(bind-key* (kbd "M-t") 'rgrep)
(bind-key* (kbd "M-d") 'compile)
(bind-key* (kbd "M-&") 'par) ;custom
(bind-key* (kbd "M-é") 'cro) ;custom
(bind-key* (kbd "M-\"") 'aco) ;custom
(bind-key* (kbd "M-\'") 'guigui) ;custom
(bind-key* (kbd "M-(") 'gui) ;custom
(bind-key* (kbd "M--") 'inc) ;custom
(bind-key* (kbd "M-è") 'main) ;custom
(bind-key* "\C-c\C-g" 'headcomment) ;custom
(bind-key* "M-q" 'comment) ;custom
(bind-key* "\C-q" 'debug) ;custom
(bind-key* "\C-i" 'indent-buffer) ;custom
;;(bind-key* "\C-g" 'indent-buffer) ;custom
;(bind-key* (kbd "M-h") 'hpp-template) ;custom
;(bind-key* (kbd "M-c") 'cpp-template) ;custom
;; (bind-key* (kbd "M-c") 'cpp-get-set-template) ;custom
;; (bind-key* (kbd "M-h") 'hpp-get-set-template) ;custom
;; (bind-key* (kbd "M-w") 'compile) ;M-d
(bind-key* (kbd "M-v") 'vc-dir)
(bind-key* "\C-c\C-d" 'diff-hl-margin-mode)
(bind-key* (kbd "C-x f") 'find-file)
(bind-key* (kbd "C-x C-f") 'find-file-other-window)
;(bind-key* (kbd "\C-x\C-b") 'ibuffer-other-window)g
(bind-key* (kbd "\C-c )") 'slime-close-all-parens-in-sexp)

(defun par()
  "par"
  (interactive)
  (insert "()")
  (backward-char 1)
)

(defun cro()
  "cro"
  (interactive)
  (insert "[]")
  (backward-char 1)
)

(defun aco()
  "ac"
  (interactive)
  (move-end-of-line 1)
  (insert "\n{")
  (indent-for-tab-command)
  (insert "\n\n}")
  (indent-for-tab-command)
  (previous-line 1)
  (indent-for-tab-command)
)

(defun guigui()
  "guigui"
  (interactive)
  (insert "\"\"")
  (backward-char 1)
)

(defun gui()
  "gui"
  (interactive)
  (insert "\'\'")
  (backward-char 1)
)

(defun inc()
  "inc"
  (interactive)
  (insert "<>")
  (backward-char 1)
  )

(defun mainarg()
  "main"
  (interactive)
  (insert "int\t\tmain(int ac, char **av)\n{\n\t\n\treturn (0);\n}\n")
  (previous-line 3)
  (forward-char 1)
  )

(defun main()
  "main"
  (interactive)
  (insert "int\t\tmain(void)\n{\n\t\n\treturn (0);\n}\n")
  (previous-line 3)
  (forward-char 1)
)

(defun normdown()
  "normdown"
  (interactive)
  (next-line 24)
)


(defun normup()
  "normup"
  (interactive)
  (previous-line 24)
)


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

(defun comment()
  "comment"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
)

(defun debug()
  "debug"
  (interactive)
  (point-to-register 'm)
  (comment-dwim nil)
  (insert "debug")
  (jump-to-register 'm)
)

(defun hpp-template(class)
  "hpp-template"
  (interactive "sClass name? ")
  (insert-hpp-template)
  (replace-string "zz" class)
;  (indent-buffer)
)

(defun cpp-template(class)
  "cpp-template"
  (interactive "sClass name? ")
  (insert-cpp-template)
  (replace-string "zz" class)
;  (indent-buffer)
)

(defun insert-hpp-template()
  "insert-hpp-template"
  (interactive)
  (header-insert)
  (goto-line 12)
;  (insert "\n#ifndef ZZ_HPP\n\n")
  (insert "\n#ifndef ZZ_CLASS_HPP\n\n")
  (insert "/*\n** defines\n*/\n")
;  (insert "# define ZZ_HPP\n\n")
  (insert "# define ZZ_CLASS_HPP\n\n")
  (insert "/*\n** includes\n*/\n")
  (insert "//# include <iostream>\n\n")
  (insert "/*\n** class\n*/\n")
  (insert "class Zz\n{\n")
  (insert "\tpublic:\n")
  (insert "\t\tZz(void);\n")
  (insert "\t\tZz(Zz const &copy);\n")
  (insert "\t\t~Zz(void);\n")
  (insert "\t\tZz\t\t&operator=(Zz const &copy);\n\n")
  (insert "\tprotected:\n\n")
  (insert "};\n\n")
;  (insert "#endif //ZZ_HPP")
  (insert "#endif //ZZ_CLASS_HPP")
  (goto-line 12)
)

(defun insert-cpp-template()
  "insert-cpp-template"
  (interactive)
  (header-insert)
  (goto-line 12)
;  (insert "\n#include \"Zz.hpp\"\n\n")
  (insert "\n#include \"Zz.class.hpp\"\n\n")
  (insert "/*\n** constructor\n*/\n")
  (insert "Zz::Zz(void)\n{\n\n}\n\n")
  (insert "Zz::Zz(Zz const &copy)\n{\n")
  (insert "\t*this = copy;\n}\n\n")
  (insert "/*\n** destructor\n*/\n")
  (insert "Zz::~Zz(void)\n{\n\n}\n\n")
  (insert "/*\n** operator overload\n*/\n")
  (insert "Zz\t\t\t\t\t&Zz::operator=(Zz const &copy)\n{\n")
  (insert "\t//this->_z = copy._z;\n\n\treturn *this;\n}\n\n")
  (insert "/*\n** public\n*/\n")
  (insert "\n\n")
  (insert "/*\n** getter/setter\n*/\n")
  (insert "\n\n")
  (insert "/*\n** protected\n*/\n")
  (insert "\n\n")
  (insert "")
  (goto-line 12)
)

(defun hpp-get-set-template(type var)
  "hpp-get-set-template"
  (interactive "stype? \nsvar name? ")
  (point-to-register 'p)
  (insert "yyy\t\t_zzz;\n")
  (insert "yyy\t\tgetZzz\(void\)\tconst;\n")
  (insert "void\t\tsetZzz\(yyy zzz\);\n")
  (goto-line 12)
  (replace-string "yyy" type)
  (goto-line 12)
  (replace-string "int\t\t_zzz" "int\t\t\t_zzz")
  (goto-line 12)
  (replace-string "int\t\tget_zzz" "int\t\t\tget_zzz")
  (goto-line 12)
  (replace-string "zzz" var)
  (indent-buffer)
  (jump-to-register 'p)
)

(defun cpp-get-set-template(type var class)
  "cpp-get-set-template"
  (interactive "stype? \nsvar name? \nsclass name? ")
  (point-to-register 'p)
  (insert "yyy\t\t\tXxx::getZzz(void)\tconst\t{ return this->_zzz; }\n")
  (insert "void\t\t\tXxx::setZzz(yyy zzz)\t\t{ this->_zzz = zzz; }\n")
  (goto-line 12)
  (replace-string "yyy" type)
  (goto-line 12)
  (replace-string "int\t\t\tXxx" "int\t\t\t\tXxx")
  (goto-line 12)
  (replace-string "zzz" var)
  (goto-line 12)
  (replace-string "xxx" class)
  (indent-buffer)
  (jump-to-register 'p)
)

(defun shell-that ()
  "Shell splitted."
  (interactive)
  (split-window-vertically)
  (next-multiframe-window)
  (shell)
)

(defun semi-c ()
  "Semi-colon at end of line, without moving!"
  (interactive)
  (point-to-register 'm)
  (move-end-of-line nil)
  (insert ";")
  (jump-to-register 'm)
)

(defun stuff (class)
  "Stuffs with CLASS."
  (interactive "sClass name? ")
;  (find-file-other-window (concat class ".cpp"))
  (find-file-other-window (concat class ".class.cpp"))
  (insert-cpp-template)
  (replace-string "zz" class)
  (save-buffer)
  (delete-window)
;  (find-file-other-window (concat class ".hpp"))
  (find-file-other-window (concat class ".class.hpp"))
  (insert-hpp-template)
  (replace-string "zz" class)
  (save-buffer)
  (delete-window)
  (shell-command "ls")
)



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
  (require 'whitespace)
  (setq whitespace-auto-cleanup t)
; (whitespace-global-mode 1)
)

