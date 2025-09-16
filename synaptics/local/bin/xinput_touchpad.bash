#!/bin/bash
#
# Software Toggle for Synaptics Touchpad
#
# SEE ALSO
# 1. https://wiki.archlinux.org/title/Touchpad_Synaptics#Using_xinput_to_determine_touchpad_capabilities
#

#DEBUG=1
USE_NOTIFY=1

if [ ! -x "$(which xinput)" ]; then
  echo "CRITICAL: Failed to find xinput..."
  echo
  echo "INFO: Install the xorg-xinput package from your distribution."
  echo
  exit 2 # ENOENT
fi

declare -i SYN_ID
declare -i SYN_STATE

#ID=$(xinput list | grep -Eio '(Synaptics)\s*id=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}')
SYN_ID=$(xinput list | grep -o -P '(Synaptics).*id=\K\d+')
[ -n "$DEBUG" ] && echo "DEBUG: $SYN_ID [id]"

SYN_STATE=$(xinput list-props "$SYN_ID" | grep 'Device Enabled' | awk '{print $4}')
[ -n "$DEBUG" ] && echo "DEBUG: $SYN_STATE [state]"

if [ "$SYN_STATE" -eq 1 ]; then
  xinput disable "$SYN_ID"
  [ -n "$DEBUG" ] && echo "DEBUG: Touchpad disabled."
  [ -n "$USE_NOTIFY" ] && notify-send -a 'Touchpad' 'Touchpad Disabled' -i input-touchpad
else
  xinput enable "$SYN_ID"
  [ -n "$DEBUG" ] && echo "DEBUG: Touchpad enabled."
  [ -n "$USE_NOTIFY" ] && notify-send -a 'Touchpad' 'Touchpad Enabled' -i input-touchpad
fi
