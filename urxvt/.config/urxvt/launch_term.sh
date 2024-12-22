#!/usr/bin/env sh

TMUX_BIN=$(command -v tmux)
TERM_BIN=$(command -v urxvtcd)
TMUX_PARAMS="attach"
TMUX_DEFAULT_PARAMS="new-session"

if [ ! -x "$TERM_BIN" ]; then
  echo "The binary at $TERM_BIN does not exist."
  TERM_BIN=$(command -v xfce4-terminal)
  echo "INFO(jeff): Using $TERM_BIN as the default."
fi

if [ ! -x "$TMUX_BIN" ]; then
  echo "The binary at $TMUX_BIN does not exist."
  exit 255
fi

exec $TERM_BIN -e "$($TMUX_BIN ${TMUX_PARAMS} $@ || $TERM_BIN -e $TMUX_BIN ${TMUX_DEFAULT_PARAMS} $@)"

exit 0
