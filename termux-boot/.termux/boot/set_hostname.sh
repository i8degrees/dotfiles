#!/data/data/com.termux/files/usr/bin/sh
# set_hostname.sh:jeff
#
# Set the device hostname (Termux on Android)
#

[ -n "$DEBUG_TRACE" ] &&
  set -o xtrace

TERMUX_HOSTNAME_FILE=/system/etc/hostname

if [ -r "$TERMUX_HOSTNAME_FILE" ]; then
  TERMUX_HOSTNAME=$(cat "$TERMUX_HOSTNAME_FILE")
  sudo hostname -F "$TERMUX_HOSTNAME_FILE"
  export TERMUX_HOSTNAME
fi

