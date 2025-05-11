#!/bin/sh -x

# rm -vf ~/.emacs.d/lisp/*/*.elc ~/.emacs.d/site-lisp/*/*.elc

mate-terminal --class EmacsTemp -x zsh -x -i -c "
  {
    pkill emacs -9 && sleep 0.5
    rm -vf ~/.emacs.d/.emacs.desktop.lock
    pgrep -af '^emacs --daemon$' || emacs --daemon |& tee ~/.log/emacs
    i3-msg 'workspace 2:emacs; exec emacsclient -c'
  } |& tee ~/.log/emacs--daemon
"
