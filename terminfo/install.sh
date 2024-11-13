#!/usr/bin/env bash
#
#

INSTALL_BASE="$HOME/dotfiles.git/terminfo"
PREFIX="$1" # $HOME/.terminfo
#PREFIX="/usr/share/terminfo" # $HOME/.terminfo
TIC_BIN=$(command -v tic) # /usr/bin/tic

check_os() {
  result="unknown"

  if [ -z "$ID" ]; then
    if [ -e "/etc/os-release" ]; then
      eval "$(cat /etc/os-release)"
    else
      echo "$result"
    fi
  fi

  if [ -n "$ID" ]; then
    result="$ID"
  fi

  echo "$result"
}

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
  os_stamp=$(check_os)
  echo $os_stamp

  install_help_text=""
  case "$os_stamp" in
    manjaro|arch)
      # TODO(JEFF): find package names
      install_help_text="sudo pacman -S ncurses"
    ;;
    alpine)
      install_help_text="apk add ncurses-terminfo"
    ;;
    freebsd|netbsd|openbsd)
      # TODO(JEFF): find package names
      install_help_text=""
    ;;
    darwin)
      # TODO(JEFF): find package names
      install_help_text="brew install ncurses"
    ;;
    debian|ubuntu)
      install_help_text="apt install ncurses-bin"
    ;;
    windows|cygwin)
      # TODO(JEFF): find package names
      install_help_text="brew install ncurses"
    ;;
    *)
      # do nothing default
    ;;
  esac

  printf "\t"
  echo "$install_help_text"
  echo
  exit 255
fi
exit 255
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

