#!/bin/zsh -x

pkill emacs -9 && sleep 1
rm ~/.emacs.d/.emacs.desktop.lock
rm -v ~/.emacs.d/lisp/*.elc
mate-terminal -x zsh -i -c "emacsclient -t "$@"; zsh"

$SHELL
