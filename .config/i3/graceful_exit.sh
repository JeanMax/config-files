#!/bin/bash

if pgrep emacs; then  # assuming it's the daemon...
    emacsclient -e '(progn
                      (kill-matching-buffers "^timemachine:.*")
                      (save-some-buffers)
                      (desktop-save "~/.emacs.d")
                      (kill-emacs))' || exit 42
fi

for app in $(wmctrl -l | cut -d' ' -f1); do
	  wmctrl -i -c $app
done

for i in {0..100}; do
    if ! pgrep 'firefox|emacs|chrom'; then
        sync
        exit 0
        # all good
    fi
    sleep 0.1
done
exit 42
