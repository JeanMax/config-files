#!/bin/bash
set -ex

# tag=emacs-22.3
# tag=emacs-23.4
# tag=emacs-24.5
# tag=emacs-25.3
# tag=emacs-26.3
# tag=emacs-27.2
# tag=emacs-28.2
tag=emacs-29.3

with_prefix=t

with_x=pgtk
with_toolkit=t


src_dir=~/code/emacs
src_git=https://github.com/emacs-mirror/emacs
build_dir=~/emacs-builds/${tag}$(test "$with_x" && echo -${with_x})$(test "$with_toolkit" && echo -tool)
mkdir -pv $build_dir

maybe_prefixed=$(test "$with_prefix" && echo --prefix=$build_dir || true)
maybe_treesitter=$(grep -q 29 <<< $tag && echo --with-tree-sitter || true)

if ! test "$with_x"; then
    maybe_with_x="--without-x --without-pgtk"
else
    # maybe_with_x="--with-x --without-pgtk"
    maybe_with_x="--without-x --with-pgtk"
    if test "$with_toolkit"; then
        # maybe_with_x+=" --with-x-toolkit=gtk3"
        maybe_with_x+=" --with-toolkit-scroll-bars"
    else
        maybe_with_x+=" --with-x-toolkit=no"
    fi
    maybe_with_x+=" --with-imagemagick"
    # --with-xwidgets"
fi

test -e $src_dir || git clone $src_git $src_dir
cd $src_dir
make maintainer-clean
git clean -f
git checkout .
git checkout $tag

sed -i 's| pgtk_display_x_warning| // zboub|' src/pgtkterm.c

export CFLAGS="-O2 -pipe -march=native -fomit-frame-pointer -fdiagnostics-color=always "
export NATIVE_FULL_AOT=1
./autogen.sh

./configure --with-zlib \
            --enable-cross-guesses=risky \
            --with-native-compilation=aot \
            --without-compress-install \
            --with-mailutils \
            --with-json  \
            --with-modules \
            --with-small-ja-dic \
            --with-libsystemd \
            --without-gconf \
            --program-transform-name='s/\([ec]tags\)/\1.emacs/' \
            $maybe_with_x $maybe_treesitter $maybe_prefixed

# "experimental"
# --enable-link-time-optimization \

make -j$(nproc)
make -j$(nproc) trampolines
sudo make install
