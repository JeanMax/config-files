;;; custom.el --- some room for emacs-generated config
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    custom.el                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2020/04/08 10:59:41 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(csv-separators '(";" "\11"))
 '(emms-player-list '(emms-player-vlc emms-player-vlc-playlist))
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(flycheck-clang-language-standard "c++17")
 '(flycheck-flake8-maximum-line-length 120)
 '(gnus-visible-headers
   '("^From:" "^Newsgroups:" "^Subject:" "^Date:" "^Followup-To:" "^Reply-To:" "^Organization:" "^Summary:" "^Keywords:" "^To:" "^[BGF]?Cc:" "^Posted-To:" "^Mail-Copies-To:" "^Mail-Followup-To:" "^Apparently-To:" "^Gnus-Warning:" "^Resent-From:" "^X-Sent:" "^X-AnteSpam-Report:"))
 '(indent-guide-char "⋮")
 '(indent-guide-recursive t)
 '(indent-tabs-mode nil)
 '(jedi:complete-on-dot t)
 '(js-indent-level 4)
 '(logview-additional-submodes
   '(("custom"
      (format . "[TIMESTAMP] MESSAGE")
      (levels . "SLF4J")
      (timestamp "pouetime")
      (aliases))))
 '(logview-additional-timestamp-formats
   '(("pouetime"
      (java-pattern . "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"))))
 '(lsp-auto-guess-root t)
 ;; '(lsp-pylsp-plugins-flake8-enabled nil)
 ;; '(lsp-pylsp-plugins-mccabe-enabled nil)
 ;; '(lsp-pylsp-plugins-pycodestyle-enabled nil)
 ;; '(lsp-pylsp-plugins-ruff-enabled t)
 '(lua-indent-level 4)
 '(magit-diff-refine-hunk t)
 '(magit-diff-refine-ignore-whitespace nil)
 '(package-selected-packages
   '(lsp-mode lsp-ui yasnippet which-key code-review logview xterm-color ansible eglot haskell-mode protobuf-mode jenkinsfile-mode dockerfile-mode docker csharp-mode luarocks lua-mode dotnet csv-mode go-mode dumb-jump inf-ruby highlight-numbers benchmark-init flycheck-ledger flycheck-grammalecte utop flycheck-ocaml merlin tuareg ledger-mode yaml-mode rjsx-mode json-mode js2-mode php-eldoc php-mode web-mode markdown-mode diff-hl git-timemachine magit company-statistics company emms keyfreq highlight-indent-guides rainbow-delimiters ace-window projectile ido-grid-mode smex flx-ido ido-completing-read+ slime bbdb flycheck-cython cython-mode gtags ggtags diminish use-package)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-subtree-depth-1-face ((t (:background "green"))))
 '(dired-subtree-depth-2-face ((t (:background "#bdbc61"))))
 '(dired-subtree-depth-3-face ((t (:background "red")))))

(provide 'custom)
;;; custom.el ends here
