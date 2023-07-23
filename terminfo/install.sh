#!/bin/sh

PREFIX=/usr/share/terminfo # $HOME/.terminfo
TIC_BIN=$(command -v tic) # /usr/bin/tic

if [ ! -x "$TIC_BIN" ]; then
  echo "CRITICAL: The termcap compiler -- tic -- was not found."
  echo
  printf "\t"
  echo "sudo apt install ncurses-bin"
  echo
  exit 255
fi

if [ ! -d "$PREFIX" ]; then
  echo "WARNING: The selected prefix path at $PREFIX does not exist."
  echo
  echo "Installing to the default prefix at $HOME."
  PREFIX="$HOME/.terminfo"
fi

tic iterm.terminfo -o $PREFIX
tic screen-256color-italic.terminfo -o $PREFIX
tic tmux-256color.terminfo -o $PREFIX
tic tmux.terminfo -o $PREFIX

