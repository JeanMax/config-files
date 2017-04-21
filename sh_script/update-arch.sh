#!/bin/bash

PACKAGES=$(yes no | sudo pacman -Syu 2>/dev/null | grep '-' | cut -d' ' -f3-)

YAOURT=$(echo 'n' | yaourt -Syu --color 2>/dev/null | grep -vE 'Synchronizing|up to date')

for p in $PACKAGES; do
    package=$(echo $p | grep -Eo '[^.]+' | head -n1 | rev | cut -d- -f2- | rev)
    clear
    echo -n "$YAOURT"
    pacman -Si $package
    sudo pacman -Sv $package
done

sudo pacman -Rns $(pacman -Qdtq)
sudo pacman-key --refresh-keys
sudo pacman-optimize
