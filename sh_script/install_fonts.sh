#!/bin/bash -x

FONT_DIR=/usr/share/fonts
# FONT_DIR=~/.local/share/fonts

NERD_FONT_URL=https://github.com/ryanoasis/nerd-fonts
RELEASE_VERSION=v3.1.1

FONT_LIST="0xProto
3270
Agave
AnonymousPro
Arimo
AurulentSansMono
BigBlueTerminal
BitstreamVeraSansMono
CascadiaCode
CascadiaMono
CodeNewRoman
ComicShannsMono
CommitMono
Cousine
D2Coding
DaddyTimeMono
DejaVuSansMono
DroidSansMono
EnvyCodeR
FantasqueSansMono
FiraCode
FiraMono
GeistMono
Go-Mono
Gohu
Hack
Hasklig
HeavyData
Hermit
iA-Writer
IBMPlexMono
Inconsolata
InconsolataGo
InconsolataLGC
IntelOneMono
Iosevka
IosevkaTerm
IosevkaTermSlab
JetBrainsMono
Lekton
LiberationMono
Lilex
MartianMono
Meslo
Monaspace
Monofur
Monoid
Mononoki
MPlus
NerdFontsSymbolsOnly
Noto
OpenDyslexic
Overpass
ProFont
ProggyClean
RobotoMono
ShareTechMono
SourceCodePro
SpaceMono
Terminus
Tinos
Ubuntu
UbuntuMono
VictorMono"

mkdir -pv $FONT_DIR
build_dir=$(mktemp -d)
(
    cd "$build_dir" || exit 42
    for font in $FONT_LIST; do
        echo "Installing $font..."
        font_archive="$font.tar.xz"
        mkdir -v "$font"
        (
            cd "$font" || exit 42
            curl -fLO "$NERD_FONT_URL/releases/download/$RELEASE_VERSION/$font_archive"
            tar -xvf "$font_archive"
            rm "$font_archive"
        )
        sudo mv "$font" "$FONT_DIR/."
    done
)
rm -rf "$build_dir"
