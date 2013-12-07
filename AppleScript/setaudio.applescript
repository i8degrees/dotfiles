#!/usr/bin/osascript
-- Dependencies
-- 1. http://whoshacks.blogspot.com/2009/01/change-audio-devices-via-shell-script.html

set loggedInUser to system attribute "USER"
do shell script "$HOME/local/bin/audiodevice system Headphones && $HOME/local/bin/audiodevice output Headphones" user name loggedInUser
