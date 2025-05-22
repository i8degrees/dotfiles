#!/bin/sh
#!/usr/bin/env bash
#
# Convenience tmux setup script; attach 
#
#

# shellcheck disable=SC3054
# shellcheck disable=SC3030
# shellcheck disable=SC3040
if [ -n "$BASH_VERSION" ]; then
  set -o pipefail
  [ -n "$DEBUG" ] && set -o errexit
  [ -n "$DEBUG_TRACE" ] && set -o xtrace
fi

USE_TMUX=1
DEFAULT_SESSION="default"
# TODO(JEFF): I think that I would like to make this an optional parameter
# where if is is an empty string, for the path not to be fed to the tmux 
# args.
DEFAULT_CWD="$HOME/Notes.git"

# IMPORTANT(JEFF): We should not depend on BASH arrays being
# available in the case that tmux is NOT chosen.
SHELL_ARGS="-l"

  #if "$(uname -a | tr '[:upper:]' '[:lower:]' | grep -i -e 'Android'>/dev/null)"; then
if [ -z "$OSTYPE" ]; then
  if ! "$(uname -a|grep -i -e 'Android' >/dev/null)"; then
    OSTYPE="linux-android"
  fi
fi

if [ "$OSTYPE" = "linux-android" ]; then
  if [ -n "$TBIN" ] && [ -n "$THOME" ]; then
    PATH="$TBIN:$THOME/bin:$THOME/local/bin:$PATH"
    echo android
  fi
else
  PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
fi

unset USE_TMUX
if [ -n "$BASH_VERSION" ]; then
  echo bash
  if [ -n "$USE_TMUX" ]; then
    CMD=(
      "tmux"
      "attach"
      "-t"
      "${DEFAULT_SESSION}"
      "-c"
      "${DEFAULT_CWD}"
    )
    if ! "${CMD[*]}"; then
      CMD=(
        "tmux"
        "new"
        "-s"
        "${DEFAULT_SESSION}"
        "-A"
        "-c"
        "${DEFAULT_CWD}"
      )
      # exec
      "${CMD[*]}"
    fi
else
  echo "not bash"
  exec "$SHELL" ${SHELL_ARGS}
  #-c 'cd ${DEFAULT_CWD}'
fi


