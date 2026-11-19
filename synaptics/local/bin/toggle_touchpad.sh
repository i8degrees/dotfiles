#!/bin/sh
# toggle_touchpad.sh:jeff
#
# shellcheck shell=bash
#
# TODO
#
# - [ ] regexp to find the correct sysfs path for the touchpad automagically.
# We will fail back to an error message informing the end-user to manually
# set the correct sysfs path when we fail at automagically doing it.
#

# >> This sys path is unique to the host that this script is used at and may need
# >> to be modified for use on other hosts.
# >>
# >> 1. cat /proc/bus/input/devices | grep -E -A 5 "Synaptics"
# >> 2. The sysfs= path given for this search result is what you must copy back over
# >> to this script.
DEV_PATH="/sys/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-DELL078B:00/0018:06CB:78F6.0008/input/input28/inhibited"

# ?? This feels like a bit of a hack here to disregard sending a notification
# ?? when you are not root, but for the mean time, it works well enough.
USERID=$(id -u)
CURRENT_STATE=$(cat "$DEV_PATH")
if [ "$CURRENT_STATE" -eq 0 ]; then
  # Inhibit (disable) the device
  echo 1 | pkexec --user root /usr/bin/tee "$DEV_PATH" > /dev/null

  if [ "$USERID" != 0 ]; then
    notify-send "Keyboard" "Built-in touchpad DISABLED" --icon=touchpad-off
  fi
else
  # Un-inhibit (enable) the device
  echo 0 | pkexec --user root /usr/bin/tee "$DEV_PATH" > /dev/null

  if [ "$USERID" != 0 ]; then
    notify-send "Keyboard" "Built-in touchpad ENABLED" --icon=touchpad-on
  fi
fi

