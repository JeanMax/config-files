;;; palette.el --- init palette
;;; Commentary:
;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    palette.el                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2016/08/24 18:42:21 by mcanal            #+#    #+#              ;
;    Updated: 2019/09/29 14:43:15 by mc               ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;; Code:

(defun unpackaged/customize-theme-faces (theme &rest faces)
  "Customize THEME with FACES.
Advises `enable-theme' with a function that customizes FACES when
THEME is enabled.  If THEME is already enabled, also applies
faces immediately.  Calls `custom-theme-set-faces', which see."
  (declare (indent defun))
  (when (member theme custom-enabled-themes)
    ;; Theme already enabled: apply faces now.
    (let ((custom--inhibit-theme-enable nil))
      (apply #'custom-theme-set-faces theme faces)))
  (let ((fn-name (intern (concat "unpackaged/enable-theme-advice-for-" (symbol-name theme)))))
    ;; Apply advice for next time theme is enabled.
    (fset fn-name
          (lambda (enabled-theme)
            (when (eq enabled-theme theme)
              (let ((custom--inhibit-theme-enable nil))
                (apply #'custom-theme-set-faces theme faces)))))
    (advice-remove #'enable-theme fn-name)
    (advice-add #'enable-theme :after fn-name)))



(defun hexrgb-hex-char-to-integer (character)
  "Take a CHARACTER and return its value as if it were a hex digit."
  (if (and (>= character ?0) (<= character ?9))
      (- character ?0)
    (let ((ch  (logior character 32)))
      (if (and (>= ch ?a) (<= ch ?f))
          (- ch (- ?a 10))
        (error "Invalid hex digit `%c'" ch)))))

(defun hexrgb-hex-to-int (hex)
  "Convert HEX string argument to an integer.
The characters of HEX must be hex characters."
  (let* ((factor  1)
         (len     (length hex))
         (indx    (1- len))
         (int     0))
    (while (>= indx 0)
      (setq int     (+ int (* factor (hexrgb-hex-char-to-integer (aref hex indx))))
            indx    (1- indx)
            factor  (* 16 factor)))
    int))

(defun hexrgb-rgb-hex-string-p (color &optional laxp)
  "Non-nil if COLOR is an RGB string #XXXXXXXXXXXX.
Each X is a hex digit.  The number of Xs must be a multiple of 3, with
the same number of Xs for each of red, green, and blue.

Non-nil optional arg LAXP means that the initial `#' is optional.  In
that case, for a valid string of hex digits: when # is present 0 is
returned; otherwise, t is returned."
  (or (string-match "^#\\([a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]\\)+$" color)
      (and laxp (string-match "^\\([a-fA-F0-9][a-fA-F0-9][a-fA-F0-9]\\)+$" color) t)))

(defun hexrgb-hex-to-rgb (color)
  "Return a list of RGB (red, green, blue) color components.
Each component is a value between 0 and 65535.
COLOR is a color name or a hex RGB string that starts with \"#\" and
is followed by an equal number (1 to 4) of hex digits for red, green,
and blue components."
  (let* ((len     (/ (1- (length color)) 3))
         (max-nb  256))
    (list (* (hexrgb-hex-to-int (substring color 1 (1+ len)))             max-nb)
          (* (hexrgb-hex-to-int (substring color (1+ len) (+ 1 len len))) max-nb)
          (* (hexrgb-hex-to-int (substring color (+ 1 len len)))          max-nb))))

(defun defcolor (color-name color-hex-value)
  "Define a new color COLOR-NAME COLOR-HEX-VALUE."
  ;; (defconst color-name color-hex-value)
  (let ((color-rgb-value (if (hexrgb-rgb-hex-string-p color-hex-value)
                             (hexrgb-hex-to-rgb color-hex-value)
                           (x-color-values color-hex-value))))
    (tty-color-define color-name 1 color-rgb-value)))


(defun load-colors ()
  "Load all ample colors."
  (defcolor "ample/green" "#6aaf50")
  (defcolor "ample/dark-green" "#057f40")
  (defcolor "ample/blue" "#5180b3")
  (defcolor "ample/blue-bg" "#102843")
  (defcolor "ample/light-blue" "#528fd1")
  (defcolor "ample/lighter-blue" "#68a5e9")
  (defcolor "ample/orange" "#dF9522")
  (defcolor "ample/tan" "#bdbc61")
  (defcolor "ample/dark-tan" "#7d7c61")
  (defcolor "ample/yellow" "#baba36")
  (defcolor "ample/bright-yellow" "#fffe0a")
  (defcolor "ample/purple" "#ab75c3")
  (defcolor "ample/light-gray" "#858585")
  (defcolor "ample/gray" "#757575")
  (defcolor "ample/dark-gray" "#656565")
  (defcolor "ample/darker-gray" "#454545")
  (defcolor "ample/darkest-gray" "#252525")
  (defcolor "ample/brown" "#987654")
  (defcolor "ample/red" "#cd5542")
  (defcolor "ample/dark-red" "#9d2512")

  (defcolor "ample/cursor" "#f57e00")
  (defcolor "ample/fringe" "#1f1f1f")
  (defcolor "ample/region" "#303030")

  (defcolor "ample/rb0" "#81b0e3")
  (defcolor "ample/rb1" "#a5a5a5")
  (defcolor "ample/rb2" "#6190c3")
  (defcolor "ample/rb3" "#959595")
  (defcolor "ample/rb4" "#4170a3")
  (defcolor "ample/rb5" "#757575")

  (defcolor "ample/bg" "gray13")
  (defcolor "ample/fg" "#bdbdb3")

  ;; custom:
  (defcolor "ample/another-tan" "#b8b74b")
  (defcolor "ample/salmon" "#ebc481"))


(add-hook 'tty-setup-hook 'load-colors)

(provide 'palette)
;;; palette.el ends here
