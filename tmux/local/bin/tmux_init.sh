#!/bin/sh
#
# Convenience tmux setup script
#
#

# shellcheck disable=SC3040
(set -o pipefail 2> /dev/null) && set -o pipefail

# shellcheck disable=SC3040
[ -n "$DEBUG" ] && (set -o errexit 2> /dev/null) && set -o errexit
# shellcheck disable=SC3040
[ -n "$DEBUG_TRACE" ] && (set -o xtrace 2>/dev/null) && set -o xtrace

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

DEFAULT_SESSION="$1"
[ -z "$DEFAULT_SESSION" ] && DEFAULT_SESSION="default"

DEFAULT_CWD="$2"
[ -z "$DEFAULT_CWD" ] && DEFAULT_CWD="$HOME/Notes.git"

if [ ! -x "$(which tmux)" ]; then
  echo "WARN: Failed to find tmux..."
  echo
  # NOTE(JEFF): Upon the first failure to find tmux, we pray that this last
  # ditch try may work -- this only applies to when we are using Termux under
  # Android OS.
  if [ -n "$TBIN" ] && [ -n "$THOME" ]; then
    PATH="$TBIN:$THOME/bin:$THOME/local/bin:$PATH"
  else
    # NOTE(JEFF): This is where we would try another method to find tmux...
    false
  fi
fi

if [ -n "$TMUX" ]; then
  return 1
else
  init_existing_session "${DEFAULT_SESSION}" "${CWD}" ||
  init_new_session "${DEFAULT_SESSION}" "${CWD}"
fi
