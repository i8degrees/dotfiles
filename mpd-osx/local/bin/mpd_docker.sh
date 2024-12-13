#!/bin/sh
#

docker stop mpd && docker rm mpd;
#  --device /dev/snd/pcmC0D0c \
#-v /mnt/fs1/Music/playlists:/music/playlists \
  #-v ./mpd.conf:/etc/mpd \
docker run -d --name mpd \
  -p 6600:6600 \
  -p 8000:8000 \
  -v /mnt/fs1/Music:/music \
gists/mpd:latest

#exec mpv http://localhost:8000

