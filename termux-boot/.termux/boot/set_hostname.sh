#!/bin/sh
# set_hostname.sh:jeff
#
# Set the device hostname (Termux on Android)
#

TERMUX_HOSTNAME_FILE=/system/etc/hostname

if [ -f "$TERMUX_HOSTNAME_FILE" ]; then
  TERMUX_HOSTNAME=$(cat "$TERMUX_HOSTNAME_FILE")
  hostname -F "$TERMUX_HOSTNAME"
  export TERMUX_HOSTNAME
fi

