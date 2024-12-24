#!/bin/sh

echo "Setting up mpd..."

sudo mkdir -p /var/lib/mpd || exit 255
sudo touch /var/log/mpd.log || echo "CRITICAL(jeff): Could not create mpd log file" && exit 255
mkdir -p /run/mpd

sudo ln -sv /home/jeff/Music /var/lib/mpd/music || mkdir /var/lib/mpd/music
sudo ln -sv /home/jeff/Music/playlists /var/lib/mpd/playlists || mkdir /var/lib/mpd/playlists

sudo chmod g+rwx /run/mpd
sudo chown :audio -R /run/mpd

exit 0

