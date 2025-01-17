#!/usr/bin/env bash
#
#

source "./lib/rc.functions"

PWD="$(pwd)"
SRC_FILES="${PWD}/dist"
TIC_BIN=$(command -v tic) # /usr/bin/tic
SUDO_BIN="$(command -v sudo)"

if [ ! -x "${SUDO_BIN}" ]; then
  echo "WARNING: sudo was not found. This may result in failure of this script."
  echo
  # exit 2
fi

if [ ! -d "$SRC_FILES" ]; then
  echo "CRITICAL: Failed to find distribution files at ${SRC_FILES}..."
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
      install_help_text="pacman -S ncurses"
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
      install_help_text="apt install ncurses-bin ncurses-term"
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
fi

TERMCAP_FILES=(
  #"${SRC_FILES}/iterm.terminfo"
  "${SRC_FILES}/screen-256color-italic.terminfo"
  "${SRC_FILES}/tmux-256color.terminfo"
  "${SRC_FILES}/tmux.terminfo"
)

cmd_exec=()
for path in "${TERMCAP_FILES[@]}"; do
  if ! check_privileges "$(id -u)"; then
    if [ -x "$SUDO_BIN" ]; then
      cmd_exec+=("sudo")
    fi
  fi

  cmd_exec+=("$TIC_BIN ${path};")
done
  
[ -n "$DRY_RUN" ] && echo "${cmd_exec[@]}"
[ -z "$DRY_RUN" ] && eval "${cmd_exec[@]}"

