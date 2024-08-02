#!/usr/bin/env bash
#
#

INSTALL_BASE="$HOME/dotfiles.git/terminfo"
PREFIX="$1" # $HOME/.terminfo
#PREFIX="/usr/share/terminfo" # $HOME/.terminfo
TIC_BIN=$(command -v tic) # /usr/bin/tic

if [ -z "$PREFIX" ]; then
  PREFIX="/usr/share/terminfo"
else
  PREFIX=$1
fi

if [ ! -x "$INSTALL_BASE" ]; then
  echo "CRITICAL: Failed to find installation files..."
  [ -n "$DEBUG" ] && echo; echo "INSTALL_BASE: ${INSTALL_BASE}"
  echo
  exit 2
fi

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

[ -n "$DEBUG" ] && echo "PREFIX: $PREFIX"

TERMCAP_FILES=(
  "${INSTALL_BASE}"/iterm.terminfo
  "${INSTALL_BASE}"/screen-256color-italic.terminfo
  "${INSTALL_BASE}"/tmux-256color.terminfo
  "${INSTALL_BASE}"/tmux.terminfo
)

for path in "${TERMCAP_FILES[@]}"; do
  [ -n "$DEBUG" ] && echo "DEBUG: " tic "$path" -o "$PREFIX"
  tic "$path" -o "$PREFIX"
done

#tic "${INSTALL_BASE}"/iterm.terminfo -o \
#  $PREFIX
#tic "${INSTALL_BASE}"/screen-256color-italic.terminfo -o \
#  $PREFIX
#tic "${INSTALL_BASE}"/tmux-256color.terminfo -o \
#  $PREFIX
#tic "${INSTALL_BASE}"/tmux.terminfo -o \
#  $PREFIX

