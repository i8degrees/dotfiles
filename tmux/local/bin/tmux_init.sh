#!/bin/sh
#
# Convenience tmux setup script
#
#

# shellcheck disable=SC3054
# shellcheck disable=SC3030
# shellcheck disable=SC3040
if [ -n "$BASH" ]; then
  set -o pipefail
  [ -n "$DEBUG" ] && set -o errexit
  [ -n "$DEBUG_TRACE" ] && set -o xtrace
fi

DEFAULT_SESSION="default"

# TODO(JEFF): I think that I would like to make this an optional parameter
# where if is is an empty string, for the path not to be fed to the tmux 
# args.
DEFAULT_CWD="$HOME/Notes.git"

#if "$(uname -a | tr '[:upper:]' '[:lower:]' | grep -i -e 'Android'>/dev/null)"; then
#if [ -z "$OSTYPE" ]; then
  #if ! "$(uname -a|grep -i -e 'Android' >/dev/null)"; then
    #OSTYPE="linux-android"
  #fi
#fi

if [ ! -x "$(which tmux)" ]; then
  if [ -n "$TBIN" ] && [ -n "$THOME" ]; then
    # echo "android"
    PATH="$TBIN:$THOME/bin:$THOME/local/bin:$PATH"
  fi
fi

tmux attach -t ${DEFAULT_SESSION} -c "${DEFAULT_CWD}" || tmux new -s "${DEFAULT_SESSION}" -A -c "${DEFAULT_CWD}"
