#!/bin/sh

[ -n "$DEBUG_TRACE" ] && set -o xtrace

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

DEFAULT_SHELL="/bin/bash"
ALT_SHELL="/bin/sh"
DEFAULT_CWD="$HOME"
TMUX_BIN="$(command -v tmux)"

if [ -x "$TMUX_BIN" ] && [ -n "$TMUX" ]; then
  tmux attach || tmux new -s default -A
else
  if [ -x "$(command -v $DEFAULT_SHELL)" ]; then
    "$DEFAULT_SHELL" -i -c "cd $DEFAULT_CWD"
  else
    "$ALT_SHELL" -c "cd $DEFAULT_CWD"
  fi
fi

