#!/usr/bin/env bash
#
# Utility functions for backup-host.sh
#

set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace

run_cmd() {
  local cmd="$*"

  if [ "$DEBUG" = "1" ] || [ "$DRY_RUN" = "1" ] || [ "$DRY_RUN" = "true" ]; then
    echo -e "DRY: ${cmd}\n"
    return 0
  else
    # execute within this script's context
    ${cmd}
    # execute by forking a new shell context / environment (perhaps more secure?)
    #/bin/sh -c ${cmd}
  fi
}

# FIXME(JEFF): Adapt function to support quotes in its argument list?
# remove inclusion switch from path list
#
# --include-dev <path>\n to <path>\n
#
# from_proxmox_include(path)
from_proxmox_include() {
  path="$@"
  echo "$path" | sed 's/--include-dev '//ig
}

# FIXME(JEFF): Adapt function to support quotes in its argument list?
# --include-dev <path>
#
# to_proxmox_include(path)
to_proxmox_include() {
  # path="$@"
  # echo "$path" | sed s/$path/"--include-dev $path"/ig
  buffer=()
  for path in "$@"; do
    buffer+=$(echo "--include-dev $path ")
  done
  echo "$buffer"
}

# remove exclusion switch from path list
#
# --exclude <path>\n to <path>\n
#
# from_proxmox_exclude(path)
from_proxmox_exclude() {
  path="$@"
  echo "$path" | sed 's/--exclude '/''/ig
}

# --exclude <path>
#
# to_proxmox_exclude(path)
to_proxmox_exclude() {
  # path="$@"
  # echo "$path" | sed "s/$path/--exclude $path"/ig
  buffer=()
  for path in "$@"; do
    buffer+=$(echo "--exclude $path ")
  done
  echo "$buffer"
}

parse_inclusions() {
  RESULT=""
  ARG="$@"

  # if $(is_proxmox_include $ARG) ]; then
  # else
  # shellcheck disable=SC2086
  RESULT=$(to_proxmox_include $ARG)
  echo "$RESULT"
}

parse_exclusions() {
  RESULT=""
  ARG="$@"

  # if $(is_proxmox_exclude $ARG) ]; then
  # else
  # shellcheck disable=SC2086
  RESULT=$(to_proxmox_exclude $ARG)
  echo "$RESULT"
}

# TODO(JEFF): This function needs to be added to test1.sh and tested thouroughly
#
# is_proxmox_include(list)
is_proxmox_include() {
  RESULT=0
  ARG="$@"

  # FIXME(JEFF): Re-write this without stdout or stderr; perhaps we can
  # redirect echo output to /dev/null or so?
  if ! echo "$ARG | grep -q -i -e '--include-dev'"; then
    RESULT=1
  fi

  return "$RESULT"
}

# TODO(JEFF): This function needs to be added to test2.sh and tested thouroughly
#
# is_proxmox_exclude(list)
is_proxmox_exclude() {
  RESULT=0
  ARG="$@"

  # FIXME(JEFF): Re-write this without stdout or stderr; perhaps we can
  # redirect echo output to /dev/null or so?
  if ! echo "$ARG | grep -q -i -e '--exclude'"; then
    RESULT=1
  fi

  return "$RESULT"
}
