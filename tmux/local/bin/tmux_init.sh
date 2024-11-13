#!/usr/bin/env bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

USE_TMUX=1

if [ -n "$USE_TMUX" ]; then
  tmux attach || tmux new -s default -A
else
  exec /bin/bash -l #-c 'cd ~/Notes.git'
fi

