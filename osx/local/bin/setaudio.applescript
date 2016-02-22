#!/usr/bin/osascript
-- Dependencies
-- 1. http://whoshacks.blogspot.com/2009/01/change-audio-devices-via-shell-script.html

-- FIXME(jeff): Update script's audio variables
set loggedInUser to system attribute "USER"
-- do shell script "$HOME/local/bin/setaudio system Headphones && $HOME/local/bin/audiodevice output Headphones" user name loggedInUser
do shell script "$HOME/local/bin/setaudio system 'Elgato Thunderbolt Dock Audio' && $HOME/local/bin/audiodevice output 'Elgato Thunderbolt Dock Audio'" user name loggedInUser

-- Help mpd reset its internal audio outputs state
do shell script "/usr/local/bin/mpc disable output 1" user name loggedInUser
do shell script "/usr/local/bin/mpc enable output 1" user name loggedInUser
