;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init.el                                            :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/04/26 16:54:03 by mcanal            #+#    #+#              ;
;    Updated: 2016/08/16 12:23:58 by mcanal           ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

;; tricks to save some startup time
(defconst initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(defconst initial-file-name-handler-alist file-name-handler-alist
  "Initial value of `file-name-handler-alist' at start-up time.")
(add-hook 'after-init-hook '
		  (lambda()
			(setq gc-cons-threshold initial-gc-cons-threshold)
			(setq file-name-handler-alist initial-file-name-handler-alist)
			(message "Init-time: %s" (emacs-init-time))))
(setq gc-cons-threshold 134217728)
(setq file-name-handler-alist nil)

;; external config
(require 'package)
(add-to-list 'package-archives
			 '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
			 '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
			 '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages (be sure it matches package-selected-packages in custom-set-variables)
(setq package-list
	  '(diff-hl flycheck web-mode php-mode tuareg highlight-chars highlight-indent-guides bind-key auto-complete fuzzy ac-etags))
(dolist (package package-list)
  (unless (package-installed-p package)
	(package-install package)))

(add-to-list 'load-path "~/.emacs.d/manually-installed/scala-mode2")
(require 'scala-mode2)

(add-to-list 'load-path "~/.emacs.d/manually-installed/42")
(require 'list)
(require 'string)
(require 'comments)
(require 'header)

(add-to-list 'load-path "~/.emacs.d/config")
(load "elisp-functions")
(load "key-binding")





;; IMPORTANT stuff
(setq tetris-score-file "~/.emacs.d/tetris-scores")
;; (setq *is-a-mac* (eq system-type 'darwin))
;; (setq *cygwin* (eq system-type 'cygwin) )
;; (setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)))

;; (global-flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; encoding
(set-language-environment "UTF-8")

;; extensions handling
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
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

;; indentation
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq fill-column 80)

;; color
(set-face-foreground 'font-lock-string-face "#E6C28F")
(set-face-foreground 'font-lock-function-name-face "royal blue")
(set-face-foreground 'font-lock-variable-name-face "orange")
(set-face-foreground 'font-lock-builtin-face "magenta")

;; col/line number
(column-number-mode 1)
(setq linum-format "%3d ")

;; backup
(setq backup-directory-alist `((".*" . ,"~/.emacs.d/backup")))
(setq auto-save-file-name-transforms `((".*" ,"~/.emacs.d/backup" t)))
(setq kept-new-versions 42)
(setq kept-old-versions 42)
(setq version-control t)

;; C hook
(add-hook 'c-mode-hook
		  (lambda()
			;; highlighting
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

			;; indentation fix (struct/switch)
			(c-set-offset 'inclass '+) ;++ me for c++ only please :O
			(c-set-offset 'case-label '+)
			)
		  )

;; rasta web-mode
(add-hook 'web-mode-hook
		  '(lambda ()
			 (set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "green")
			 (set-face-attribute 'web-mode-html-tag-face nil :foreground "green")
			 (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "yellow")
			 (set-face-attribute 'web-mode-html-attr-value-face nil :foreground "firebrick2")))

;; erc
(setq erc-save-buffer-on-part t)
(setq erc-autojoin-channels-alist
	  '((".*\\.freenode.net" "#emacs" "#trisquel" "#zboub")
		(".*\\.synirc.net" "#d2bs")))
(setq erc-keywords '("jean" "smurf"))
(erc-match-mode)
;; Truncate buffers so they don't hog core. ;;TODO: be sure it still logs
(setq erc-max-buffer-size 20000)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(setq erc-truncate-buffer-on-save t)

;; highlight matching parenthesis
(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
		 (matching-text (and cb
							 (char-equal (char-syntax cb) ?\) )
							 (blink-matching-open))))
	(when matching-text (message matching-text))))

;; ibuffer
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


;; gnus (account infos in .authinfo)
(setq gnus-select-method
	  '(nnimap "gmail"
			   (nnimap-address "imap.gmail.com")
			   (nnimap-server-port "imaps")
			   (nnimap-stream ssl)))
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
(setq message-send-mail-function 'smtpmail-send-it
	  smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
	  smtpmail-auth-credentials '(("smtp.gmail.com" 587 "mc.maxcanal@gmail.com" nil))
	  smtpmail-default-smtp-server "smtp.gmail.com"
	  smtpmail-smtp-server "smtp.gmail.com"
	  smtpmail-smtp-service 587)
(setq-default
 gnus-summary-line-format "%U%R%z %(%&user-date;  %-21,21f  %B%s%)\n"
 gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
 gnus-thread-sort-functions '(gnus-thread-sort-by-number
							  (not gnus-thread-sort-by-date)))


;; window splitting at launch
(setq split-height-threshold 25)
(setq split-width-threshold 80)

;; completion
(ac-config-default)
(add-hook 'prog-mode-hook 'ac-etags-ac-setup)
(set-default 'ac-sources
			 '(
			   ac-source-dictionary
			   ac-source-words-in-same-mode-buffers
			   ac-source-etags))
(setq ac-delay 0)              ;; 0.1
(setq ac-auto-show-menu 0.4)     ;; 0.8
(setq ac-fuzzy-cursor-color 'color-160)
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)
(eval-after-load "etags"
  '(progn
	 (ac-etags-setup)))

;; git status in dired mode
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
;; (add-hook 'prog-mode-hook 'diff-hl-mode) ;debug

;; selecting region with shift
(transient-mark-mode t) ;??

;; hide/show mod
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; diff (killring)
(defadvice kill-new (before strip-leading-diff-chars activate)
  "When copying from a diff buffer, strip the leading -, +, ! characters."
  (if (eq major-mode 'diff-mode)
	  (ad-set-arg 0 (replace-regexp-in-string "^." "" (ad-get-arg 0)))))





(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-etags-requires 2)
 '(diff-hl-highlight-function nil)
 '(diff-hl-margin-mode t)
 '(erc-log-channels-directory "~/.emacs.d/erc-log")
 '(erc-modules
   (quote
	(autojoin button completion fill irccontrols keep-place list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track)))
 '(erc-nick "JeanMax")
 '(erc-nickserv-passwords (quote ((freenode (("JeanMax" . "password"))))))
 '(erc-prompt-for-nickserv-password nil)
 '(erc-prompt-for-password nil)
 '(erc-services-mode t)
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
 '(package-selected-packages
   (quote
	(diff-hl flycheck web-mode php-mode tuareg highlight-chars highlight-indent-guides bind-key auto-complete fuzzy ac-etags)))
 '(scala-font-lock:constant-list nil)
 '(scala-indent:step 4)
 '(setq show-paren-delay t)
 '(show-paren-delay 0.1)
 '(show-paren-mode t)
 '(send-mail-function (quote smtpmail-send-it))
 '(woman-locale "en_US.UTF-8"))
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

;; zboub
