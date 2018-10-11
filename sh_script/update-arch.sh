#!/bin/bash -x

bb-wrapper --aur --build-dir /tmp/bb-build -Syu
pacman -Qdt && sudo pacman -Rns $(pacman -Qdtq)
# sudo pacman-key --refresh-keys
