#!/usr/bin/env bash
#
#
#

# Returns zero (0) if the user ID is not root
# Returns one (1) if the user ID matches that
# of the superuser (root).
#
#check_privileges(id = required)
check_privileges() {
  result=0
  userid="$1"
  if [ -z "$userid" ]; then
    return "$result"
  fi

  if [ "$userid" = "0" ]; then
    result=1
  fi

  return "$result"
}

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

# get_install_prefix(typeStr = str)
get_install_prefix() {
  result="$HOME/.terminfo"
  typeStr="$1"
  if [[ "$typeStr" =~ /user/ ]]; then
    true
  elif [[ "$typeStr" =~ /system/ ]]; then
    if ! check_privileges "$(id -u)" && [[ -x "$SUDO_BIN" ]]; then
      result="$(sudo tic -D 2>/dev/null)"
    else
      # sudo not installed or missing
      result="$(tic -D 2>/dev/null)"
    fi
  fi

  echo "$result"
}

SUDO_BIN="$(command -v sudo)"
PREFIX=""
  #"/etc/terminfo"
  #"$HOME/.terminfo"
DEST_FILES=()
cmd_exec=()

PREFIX="$(get_install_prefix "user")"

#"${PREFIX}/i/iTerm.app"
DEST_FILES=(
  "${PREFIX}/s/screen-256color-italic"
  "${PREFIX}/t/tmux-256color"
  "${PREFIX}/t/tmux"
  "${PREFIX}/x/xterm-256color-italic"
)

if [ -n "$DEBUG" ]; then
  echo "PREFIX=${PREFIX[@]}"
fi

for path in "${DEST_FILES[@]}"; do
  if ! check_privileges "$(id -u)" && [[ -x "$SUDO_BIN" ]]; then
    cmd_exec+=("sudo")
  fi
  echo "rm -fv $path"
  #cmd_exec+=("rm -fv ${path};")
done

[ -n "$DEBUG" ] && echo "DEBUG: ${cmd_exec[$*]}"
[ -z "$DRY_RUN" ] && eval "${cmd_exec[@]}"

# shellcheck disable=SC2181
if [ "$?" = "0" ]; then
  echo "INFO: Removal of termcap files is completed..."
  echo
fi

