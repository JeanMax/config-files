#!/bin/sh -x

# rm -vf ~/.emacs.d/lisp/*/*.elc ~/.emacs.d/site-lisp/*/*.elc

mate-terminal --class EmacsTerm -x zsh -i -c "
  pkill emacs -9 && sleep 0.5
  rm -vf ~/.emacs.d/.emacs.desktop.lock
  emacsclient -t "$@"
  zsh"
