;;; init.el --- init emacs
;;; -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; (setq debug-on-error t)  ; --debug-init

(when (< emacs-major-version 22)
  (error "Emacs version 22 or greater required!"))


;; (setq package-enable-at-startup nil)


;; tricks to save some startup time
;; ( https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/ )
;; (let ((gc-cons-threshold most-positive-fixnum))

(setq gc-cons-threshold (* 64 1024 1024))
(setq gc-cons-percentage 0.8)
(defconst initial-gc-cons-threshold gc-cons-threshold)

;; (add-hook 'minibuffer-setup-hook
;; 		  #'(lambda () (setq gc-cons-threshold most-positive-fixnum)))
;; (add-hook 'minibuffer-exit-hook
;; 		  #'(lambda () (setq gc-cons-threshold initial-gc-cons-threshold)))


(defconst initial-file-name-handler-alist file-name-handler-alist)
(add-hook 'after-init-hook
		  #'(lambda ()
			  ;; (setq gc-cons-threshold initial-gc-cons-threshold)
			  (setq file-name-handler-alist initial-file-name-handler-alist)
			  (message "Init-time: %s" (emacs-init-time))))
(setq file-name-handler-alist nil)


(setq read-process-output-max (* 1024 1024)) ;; 1mb

(setq lexical-binding t)



(provide 'realy-init)
;;; early-init.el ends here
