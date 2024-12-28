#!/usr/bin/env bash
#
# Utility functions for backup-host.sh
#

set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace

# globals
readonly INCLUDE_DEV_STR="--include-dev" # proxmox-backup-client v3.2.x
readonly EXCLUDE_DEV_STR="--exclude" # proxmox-backup-client v3.2.x

# params: Message, Assertion
#
# assert(messageStr, assertion)
#
# 1. assert "Passes when true" "1 == 1"
# 2. assert "Fails when false" "1 == 2"
# http://tldp.org/LDP/abs/html/debugging.html#ASSERT
assert() {
  E_PARAM_ERR=98
  E_ASSERT_FAILED=99

  if [ -z "$2" ]
  then
    return $E_PARAM_ERR
  fi

  message=$1
  assertion=$2

  if [ ! "$assertion" ]
  then
    echo "❌ $message"
    exit $E_ASSERT_FAILED
  else
    echo "✅ $message"
    return
  fi
}

run_cmd() {
  local cmd="$*" # array as a string

  if [ "$DRY_RUN" = "1" ] || [ "$DRY_RUN" = "true" ]; then
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
  # path="$*"
  # echo "$path" | sed 's/--include-dev '//ig
  printf '%s' "$path" | sed 's/--include-dev '/''/ig
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
    buffer+=$(printf '%s' "$INCLUDE_DEV_STR $path ")
    # buffer+=$(echo "--include-dev $path ")
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
  # path="$*"
  # echo "$path" | sed 's/--exclude '/''/ig
  printf '%s' "$path" | sed 's/--exclude '/''/ig
}

# --exclude <path>
#
# to_proxmox_exclude(path)
to_proxmox_exclude() {
  # path="$@"
  # echo "$path" | sed "s/$path/--exclude $path"/ig
  buffer=()
  for path in "$@"; do
    buffer+=$(printf '%s' "$EXCLUDE_DEV_STR $path ")
    # buffer+=$(echo "--exclude $path ")
  done
  echo "$buffer"
}

parse_inclusions() {
  RESULT=""
  ARG="$@"
  # ARG="$*"

  # if $(is_proxmox_include $ARG) ]; then
  # else
  # shellcheck disable=SC2086
  RESULT=$(to_proxmox_include $ARG)
  echo "$RESULT"
}

parse_exclusions() {
  RESULT=""
  ARG="$@"
  # ARG="$*"

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
  # ARG="$*"

  if [[ "$ARG" =~ /"${INCLUDE_DEV_STR}"/ig ]]; then
    RESULT=1
  fi
  # FIXME(JEFF): Re-write this without stdout or stderr; perhaps we can
  # redirect echo output to /dev/null or so?
  # if ! echo "$ARG" | grep -q -i -e "$INCLUDE_DEV_STR"; then
    # RESULT=1
  # fi

  return "$RESULT"
}

# TODO(JEFF): This function needs to be added to test2.sh and tested thouroughly
#
# is_proxmox_exclude(list)
is_proxmox_exclude() {
  RESULT=0
  ARG="$@"
  # ARG="$*"

  if [[ "$ARG" =~ /"${EXCLUDE_DEV_STR}"/ig ]]; then
    RESULT=1
  fi
  # FIXME(JEFF): Re-write this without stdout or stderr; perhaps we can
  # redirect echo output to /dev/null or so?
  # if ! echo "$ARG" | grep -q -i -e "$EXCLUDE_DEV_STR"; then
    # RESULT=1
  # fi

  return "$RESULT"
}

script_name() {
  echo $(basename "$0")
}

# Print usage information, and optionally, when an exit code is provided,
# exit the script with the specified exit code.
#
# exit_code - unsigned integer
#
# usage_info(exit_code)
usage_info() {
  name=$(script_name)
  version=$(generate_build_version "true")
  exit_code="$1"

  echo -e "Usage:\n"
  echo -e "\t${name} v${version} [OPTIONS] <system|home> <HOSTNAME>\n"
  echo -e "Options:\n"
  echo -e "\t-h,  --help\tDisplay this help text and exit\n"
  echo -e "\t-X,  --exclusion-file\tProvide an exclusion list file\n"
  echo -e "\t-f,  --file\tLoad host-specific environment\n"
  echo

  if [ "$exit_code" != "" ]; then
    exit "$exit_code"
  fi
}

# Use the sha commit of the git repo at HEAD~0 as a version string
#
# shorten_str (optional) - boolean value
#
# returns a string that is the first 41 bytes of the sha commit when
# `shorten_str` is *false*
# returns a string that is the first 7 bytes of the sha commit when
# `shorten_str` is *true*.
#
# generate_build_version(bool shorten_str="false")
generate_build_version() {
  SHORT_STR="$1"
  if [ -z "$SHORT_STR" ] || [ "$SHORT_STR" != "true" ] && [ "$SHORT_STR" != "1" ]; then
    echo "$(git rev-parse HEAD~0)"
  else
    echo "$(git rev-parse --short HEAD~0)"
  fi
}

# Specific cleanup code for sanitizing the passwords from memory; this
# function is safe to be called explicitly.
#
# void cleanup_passwords()
cleanup_passwords() {
  # shellcheck disable=SC2034
  PBS_PASSWORD=""; unset PBS_PASSWORD
  # shellcheck disable=SC2034
  PASSPHRASE=""; unset PASSPHRASE
}

# Trap function; this function is also safe to call directly.
#
# void cleanup()
cleanup() {
  run_cmd proxmox-backup-client logout
  cleanup_passwords

  # shellcheck disable=SC2034
  REPOSITORY=""; unset REPOSITORY
  # shellcheck disable=SC2034
  EXCLUSIONS=""; unset EXCLUSIONS
}

build_run_cmd() {
  ARGS=()
  readonly TYPE="$1"
  readonly NS="$2"

  if [ "$TYPE" = "home" ]; then
    # shellcheck disable=SC2206
    ARGS+=("${HOST}_home.pxar:/home" $EXCLUSIONS_LIST $INCLUDES)
  elif [ "$TYPE" = "root" ] || [ "$TYPE" = "system" ]; then
    # shellcheck disable=SC2206
    ARGS+=("${HOST}_root.pxar:/" $EXCLUSIONS_LIST $INCLUDES)
  # else
    # ARGS+=("$TYPE" $EXCLUSIONS_LIST $INCLUDES)
  fi

  if [ -n "$NS" ]; then
    ARGS+=("--ns" "$NS")
  fi

  echo "${ARGS[*]}"
}
