#!/bin/sh
#
# ~/.tmux/themes.tmux:jeff
#
# tmux themes environment
#
# SEE ALSO
# 1. ~/.bash/bashrc.d/human-plus-plus.sh for detail
#

[ -z "${HPP_DIR}" ] && exit 1

# init the human-plus-plus theme for tmux
if [ -r "${HPP_DIR}/vendor/human-plus-plus.git/dist/tmux/human-plus-plus.conf" ]; then
  tmux source-file "${HPP_DIR}/vendor/human-plus-plus.git/dist/tmux/human-plus-plus.conf"
fi

