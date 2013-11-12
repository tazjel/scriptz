#!/bin/sh
#Description: turns a torrent hash into a magnet link and copy it to the clipboard
HASH="$1"
TRACKERS="&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337"

echo "magnet:?xt=urn:btih:${HASH}${TRACKERS}" | xclip -selection c
