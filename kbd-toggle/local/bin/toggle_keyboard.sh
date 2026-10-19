#!/bin/sh
# toggle_keyboard.sh:jeff
#
# shellcheck shell=bash
#
# TODO
#
# - [ ] regexp to find the correct sysfs path for the keyboard automagically.
# We will fail back to an error message informing the end-user to manually
# set the correct sysfs path when we fail at automagically doing it.
#

# >> This sys path is unique to the host that this script is used at and may need
# >> to be modified for use on other hosts.
# >>
# >> 1. cat /proc/bus/input/devices | grep -E -A 5 "AT Translated Set 2 keyboard"
# >> 2. The sysfs= path given for this search result is what you must copy back over
# >> to this script.
KEYBOARD_PATH="/sys/devices/platform/i8042/serio0/input/input4/inhibited"

# ?? This feels like a bit of a hack here to disregard sending a notification
# ?? when you are not root, but for the mean time, it works well enough.
USERID=$(id -u)
CURRENT_STATE=$(cat "$KEYBOARD_PATH")
if [ "$CURRENT_STATE" -eq 0 ]; then
  # Inhibit (disable) the keyboard
  echo 1 | pkexec --user root /usr/bin/tee "$KEYBOARD_PATH" > /dev/null

  if [ "$USERID" != 0 ]; then
    notify-send "Keyboard" "Built-in keyboard DISABLED" --icon=keyboard-off
  fi
else
  # Un-inhibit (enable) the keyboard
  echo 0 | pkexec --user root /usr/bin/tee "$KEYBOARD_PATH" > /dev/null

  if [ "$USERID" != 0 ]; then
    notify-send "Keyboard" "Built-in keyboard ENABLED" --icon=keyboard-on
  fi
fi

