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

parse_root_includes() {
  RESULT=""

  ROOT_INCLUDES="$1"
  if [ "$ROOT_INCLUDES" = "" ]; then
    echo "$RESULT"
    return 1
  fi

  # if echo "$ROOT_INCLUDES | grep -q -i -e '--include-dev'"; then
  # shellcheck disable=SC2086
  RESULT=$(to_proxmox_include $ROOT_INCLUDES)

  echo "$RESULT"
}

parse_home_includes() {
  RESULT=""
  HOME_INCLUDES="$1"

  if [ "$HOME_INCLUDES" = "" ]; then
    echo "$RESULT"
    return 1
  fi

  # if echo "$HOME_INCLUDES | grep -q -i -e '--include-dev'"; then
  # shellcheck disable=SC2086
  RESULT=$(to_proxmox_include $HOME_INCLUDES)

  echo "$RESULT"
}

parse_exclusions() {
  RESULT=""

  EXCLUSIONS="$1"
  if [ "$EXCLUSIONS" = "" ]; then
    echo "$RESULT"
    return 1
  fi

  # if echo "$EXCLUSIONS | grep -q -i -e '--exclude'"; then
  # shellcheck disable=SC2086
  RESULT=$(to_proxmox_exclude $EXCLUSIONS)

  echo "$RESULT"
}
