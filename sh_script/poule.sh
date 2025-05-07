#!/bin/bash

set -x

test "$1" && STASH=t

if test "$STASH" && test "$(git status --porcelain)"; then
    stashed=t
    git stash -m poule
fi

git pull
git submodule sync
git submodule update --init --recursive


test "$stashed" && git stash pop
