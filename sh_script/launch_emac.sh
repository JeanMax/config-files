#!/bin/sh -x

mate-terminal --class EmacsTerm -x zsh -i -c "
  pkill emacs -9 && sleep 0.5
  rm -vf ~/.emacs.d/lisp/*.elc ~/.emacs.d/.emacs.desktop.lock
  emacsclient -t "$@"
  zsh"
