#!/bin/bash
#Description: Convert animated gifs to ogg video files
#Source: https://github.com/nodiscc/scriptz
#License: MIT (http://opensource.org/licenses/MIT)
#Dependencies: avconv, mplayer
#Saves a lot of space without sacrificing quality. Plays nice with mplayer -loop 0 output.ogv 
#TODO: make the output cleaner/more informative
set -e


USAGE="USAGE: `basename $0` [ -d ] file1.gif file2.gif ...
OPTIONS:    -d    delete original after conversion"


if [ "$1" = "-d" ]
then DELETE_ORIGINAL="true"; shift
elif [ "$1" = "-h" -o "$1" = "--help" -o "$1" = "" ]
then echo "$USAGE"; exit 0
fi

for file in $@
do
    FTYPE=`file --brief --mime "$file" |awk '{print $1}'`
    if [ "$FTYPE" != "image/gif;" ] #Check if file is a gif
        then echo "File $file is not a gif image."; exit 1
    fi
    mplayer "$file" -vo yuv4mpeg #convert the gif to a yuv stream
    avconv -r 25 -i stream.yuv -c:v libtheora -q:v 6 -r 25 "$file".ogv #Do the actual conversion. note that 25fps is arbitrary. Quality is set to 6 which gives correct results with a rather low bitrate
    rm stream.yuv
    if [ "$DELETE_ORIGINAL" = "true" ]
        then rm "$file"
    fi
done