#!/bin/bash -xe

install_dir=$(mktemp -d)/yay
git clone https://aur.archlinux.org/yay.git "$install_dir"
(
    cd "$install_dir"
    # last_tag="$(git tag | tail -n1)"
    # git checkout "$last_tag"
    makepkg -si
)
rm -rf "$install_dir"
