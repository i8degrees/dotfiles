#!/usr/bin/env sh

TMUX_BIN=$(which tmux)
TMUX_PARAMS_EXISTING="attach"
TMUX_PARAMS_NEW="new-session"

# IMPORTANT(jeff): Always attach to an existing tmux session anytime we can!  
$TMUX_BIN $TMUX_PARAMS_EXISTING || $TMUX_BIN $TMUX_PARAMS_NEW
