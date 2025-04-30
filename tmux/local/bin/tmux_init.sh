#!/usr/bin/env bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# TODO(JEFF): I think that I would like to make this an optional parameter
# where if is is an empty string, for the path not to be fed to the tmux 
# args.
CWD="$HOME/Notes.git"

USE_TMUX=1

if [ -n "$USE_TMUX" ]; then
  tmux attach -tdefault -c "$CWD" || tmux new -s default -A -c "$CWD"
else
  exec /bin/bash -l #-c 'cd ~/Notes.git'
fi

