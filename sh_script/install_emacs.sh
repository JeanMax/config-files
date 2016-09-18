#!/bin/bash
set -ex

sudo test true
../emacs_git/configure --without-x --without-xpm --without-jpeg --without-png --without-rsvg --without-imagemagick --without-tiff --without-gif
make
sudo make install
