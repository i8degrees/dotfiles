#!/bin/sh
#
# ~/.bash_logout: executed by bash(1) when login shell exits.
#

console_clear() {
  # when leaving the console clear the screen to increase privacy
  if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
  fi
}

case "$(uname -s)" in
  Darwin)
    console_clear
  ;;
  Linux)
    # restore ALSA sfx levels
    #alsactl -f "$HOME/.asound.state store 0"
    #alsactl -f "$HOME/.asound.state store 1"
    console_clear
  ;;
  *)
    console_clear
  ;;
esac
