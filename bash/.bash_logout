#!/bin/bash
#
# 2016-02/17:jeff
#
# Executed on logout by Bash

case "$(uname -s)" in
  Darwin)
    # ...
  ;;
  Linux)
    # restore ALSA sfx levels
    #alsactl -f "$HOME/.asound.state store 0"
    #alsactl -f "$HOME/.asound.state store 1"
  ;;
  *)
    # Catch-all
  ;;
esac
