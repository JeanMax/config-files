;;; init-python-mode.el --- init python-mode
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    init-python-mode.el                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/07/31 18:06:12 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:
(use-package python
  :defer t
  :mode
  ("\\.py\\'" . python-mode)

  :init
  (progn
    (setenv "FORCE_COLOR" "t")
    (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
    (setenv "PATH" (concat "~/.local/bin:" (getenv "PATH")))
    (add-hook 'python-mode-hook 'eldoc-mode)

    (setq python-eldoc-setup-code
          "def __PYDOC_get_help(obj):
    try:
        import inspect
        try:
            str_type = basestring
        except NameError:
            str_type = str
        if isinstance(obj, str_type):
            obj = eval(obj, globals())
        doc = inspect.getdoc(obj)
        ret = ''
        if callable(obj):
            target = None
            if inspect.isclass(obj) and hasattr(obj, '__init__'):
                target = obj.__init__
                objtype = 'class'
            else:
                target = obj
                objtype = 'def'
            if target:
                args = inspect.formatargspec(
                    *inspect.getfullargspec(target)
                )
                name = obj.__name__
                ret = '{objtype} {name}{args}'.format(
                    objtype=objtype, name=name, args=args
                )
                if doc:
                    ret = ret + \"  ---  \"
        if doc:
            ret = ret + '\"\"\"' + doc.splitlines()[0] + '\"\"\"'
    except:
        ret = ''
    return ret")

    (setq python-shell-interpreter "ipython"
          python-shell-interpreter-args "--pdb -i --simple-prompt --InteractiveShell.display_page=True")

    (use-package cython-mode
      :ensure t
      :defer t
      :mode
      ("\\.pyx\\'" . cython-mode)

      :config
      ;; free that for dabbrev-expand
      (define-key python-mode-map (kbd "<backtab>") nil)

      :init
      (progn
        (use-package flycheck-cython
          :defer t
          :ensure t

          :init
          (add-hook 'cython-mode-hook 'flycheck-mode)))))

  :config
  ;; free that for dabbrev-expand
  (define-key python-mode-map (kbd "<backtab>") nil)
  (define-key python-mode-map (kbd "C-c f") 'insert-python-def)

  (define-key inferior-python-mode-map (kbd "C-c r") 'comint-history-isearch-backward)
  (define-key inferior-python-mode-map (kbd "C-c l") 'comint-clear-buffer))

;; (setq major-mode-remap-alist
;;       '((python-mode . python-ts-mode)))

;; (defun ipython()
;;   (interactive)
;;   (ansi-term "~/babao/babao" "Python"))

(defun insert-python-def (fun)
  "Insert a formated python def FUN function."
  (interactive "sfunction name: ")
  (insert (concat "def " fun "():\n"))
  (indent-according-to-mode)
  (insert "\"\"\"TODO\"\"\"\n\n")
  (indent-according-to-mode))



(use-package eldoc
  :defer t
  :diminish eldoc-mode)


(provide 'init-python-mode)
;;; init-python-mode.el ends here
