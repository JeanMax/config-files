#!/bin/bash -x

yaourt --noconfirm --aur -Syu
# bb-wrapper --build-dir /tmp/bb-build --aur -Syu
pacman -Qdt && sudo pacman -Rns $(pacman -Qdtq)
# sudo pacman-key --refresh-keys
