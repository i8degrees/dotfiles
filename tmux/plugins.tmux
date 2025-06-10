#!/bin/sh
#
# ~/.tmux/plugins.tmux:jeff
#
# tmux plugins env

xdg_open="$(which xdg-open)"

if [ -e "$xdg_open" ]; then
  tmux set -g @plugin 'tmux-plugins/tmux-open'
  # NOTE(JEFF): tmux-open opts
  tmux set -g @open-S 'https://www.google.com/search?q='
  # ^ CTRL+o
  tmux set -g @open-editor 'C-o'
fi

