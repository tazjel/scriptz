#!/bin/bash
#
# By Sirupsen @ http://sirupsen.dk
#		@ xunicorn
#
# Description: Upload an image to imgur
#
# Dependencies: Xclip, libnotify-bin

#TODO: display a progress bar/spinner
#TODO: make notifications persistent
#TODO: add a copy button to the notifications


function uploadImage {
  curl -s -F "image=@$1" -F "key=486690f872c678126a2c09a9e196ce1b" http://imgur.com/api/upload.xml | grep -E -o "<original_image>(.)*</original_image>" | grep -E -o "http://i.imgur.com/[^<]*"
}

capturefile="$1"
uploadImage "$capturefile" | xclip -selection c
notify-send -i gnome-screenshot "Upload done" "Image uploaded to `xclip -selection c -o`, address copied to clipboard"
