#!/usr/bin/osascript
--
-- Jeffrey Carpenter <jeffrey.carp@gmail.com>
--
-- FIXME: Use as an application bundle (Application file format) with option "Run-only"
--
-- FIXME: Used with SteerMouse profile for Hermes app
--
-- Source: https://github.com/alexcrichton/hermes/blob/master/README.md

on run {command}
  if command = "toggle"
    toggle_play()
  else if command = "volume+"
    volume_up()
  else if command = "volume-"
    volume_down()
  else if command = "thumbs+"
    thumbs_up()
  else if command = "thumbs-"
    thumbs_down()
  end if -- command
end run

on toggle_play()
  tell application "Hermes"
    playpause
  end tell
end toggle_play

on volume_up()
  tell application "Hermes"
    raise volume
  end tell
end volume_up

on volume_down()
  tell application "Hermes"
    lower volume
  end tell
end volume_down

on thumbs_up()
  tell application "Hermes"
    thumbs up
  end tell
end thumbs_up

on thumbs_down()
  tell application "Hermes"
    thumbs down
  end tell
end thumbs_down
