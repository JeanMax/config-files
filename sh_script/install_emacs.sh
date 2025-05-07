#!/bin/bash
set -ex

sudo test true
./autogen.sh
./configure --without-x --without-xpm --without-jpeg --without-png --without-rsvg --without-imagemagick --without-tiff --without-gif --without-lcms2 --without-toolkit-scroll-bars --enable-link-time-optimization --enable-cross-guesses=risky --with-mailutils --with-x-toolkit=no  --with-json --with-tree-sitter --with-native-compilation=aot
make
sudo make install
