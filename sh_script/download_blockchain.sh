#!/bin/bash -xe

DOWNLOAD_DIR=~/Downloads/blockchain


TORRENT_DIR="$DOWNLOAD_DIR/.torrents"
URL="https://getbitcoinblockchain.com"

mkdir -pv "$TORRENT_DIR"
for torrent in {blockchain,update}.torrent; do
    if ! test -e "$TORRENT_DIR/$torrent"; then
        wget "$URL/$torrent" -O "$TORRENT_DIR/$torrent"
    fi
    transmission-cli -D -u 0 -w "$DOWNLOAD_DIR" "$TORRENT_DIR/$torrent" &
done


while pgrep transmission-cli; do
    sleep 1;
done
