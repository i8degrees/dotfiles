#!/bin/sh
#
# Convenience tmux setup script
#
#

init_new_session() {
  session="$1"
  cwd="$1"

  echo "INFO: Failed to find an existing session..."
  echo "INFO: Creating a new tmux session ${session}..."

  if [ "${cwd}" != "" ] && [ -e "${cwd}" ]; then
    tmux new -s "${session}" -A -c "${cwd}"
  else
    tmux new -s "${session}" -A
  fi
}

init_existing_session() {
  session="$1"
  cwd="$2"

  echo "INFO: Found an existing tmux session..."
  echo "INFO: Attaching the existing tmux session..."

  if [ "${cwd}" != "" ] && [ -e "${cwd}" ]; then
    tmux attach -t "${session}" -c "${cwd}"
  else
    tmux attach -t "${session}"
  fi
}

if [ -n "$BASH" ]; then
  set -o pipefail
  [ -n "$DEBUG" ] && set -o errexit
  [ -n "$DEBUG_TRACE" ] && set -o xtrace
fi

DEFAULT_SESSION="$1"
[ -z "$DEFAULT_SESSION" ] && DEFAULT_SESSION="default"

DEFAULT_CWD="$2"
[ -z "$DEFAULT_CWD" ] && DEFAULT_CWD="$HOME/dotfiles.git"

#if "$(uname -a | tr '[:upper:]' '[:lower:]' | grep -i -e 'Android'>/dev/null)"; then
#if [ -z "$OSTYPE" ]; then
  #if ! "$(uname -a|grep -i -e 'Android' >/dev/null)"; then
    #OSTYPE="linux-android"
  #fi
#fi

if [ ! -x "$(which tmux)" ]; then
  echo "WARN: Failed to find tmux..."
  echo
  if [ -n "$TBIN" ] && [ -n "$THOME" ]; then
    # echo "android"
    PATH="$TBIN:$THOME/bin:$THOME/local/bin:$PATH"
  fi
fi


init_existing_session "${DEFAULT_SESSION}" "${CWD}" ||
init_new_session "${DEFAULT_SESSION}" "${CWD}"

