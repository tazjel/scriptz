#!/bin/bash
#Convert animated gifs to ogg video files
#Source: https://github.com/nodiscc/scriptz
#License: MIT (http://opensource.org/licenses/MIT)


FTYPE=`file --brief --mime pipad_gif_600_med.gif |awk '{print $1}'`
if [ "$FTYPE" != "image/gif;" ]
	then echo "File is not a gif image."; exit 1
fi

#TODO: make the output cleaner/more informative
#convert the gif to a yuv stream
mplayer "$1" -vo yuv4mpeg
#Do the actual conversion. note that 25fps is arbitrary. Quality is set to 6 which gives correct results with a rather low bitrate
avconv -r 25 -i stream.yuv -c:v libtheora -q:v 6 -r 25 "$1".ogv
rm stream.yuv