#!/bin/sh
#
# 2011-09/09:jeffrey.carp@gmail.com
#
#		~/.bash_logout
#

reset_terminal() {
  clear
  reset
}

case "$(uname -s)" in
  Darwin)
    reset_terminal
  ;;
  Linux)
    # restore ALSA sfx levels
    #alsactl -f "$HOME/.asound.state store 0"
    #alsactl -f "$HOME/.asound.state store 1"
    reset_terminal
  ;;
  *)
    reset_terminal
  ;;
esac
