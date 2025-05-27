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

DEFAULT_SESSION="$1"
[ -z "$DEFAULT_SESSION" ] && DEFAULT_SESSION="default"

DEFAULT_CWD="$2"
[ -z "$DEFAULT_CWD" ] && DEFAULT_CWD="$HOME/Notes.git"

usage_text() {
  name="tmux_init.sh"
  version="1.0.0"
  usage="--posix"
  echo "$name" v"$version"
  echo "Usage: $usage"

  exit_code="$1"
  if [ "$exit_code" ]; then
    exit "$exit_code"
  fi
}

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

_tmux_init() {
  session="$1" # required
  if [ -z "$session" ]; then
    return 2 # ENOINT
  fi

  cwd="$2" # required
  if [ -z "$cwd" ]; then
    return 2 # ENOINT
  fi

  exit_code="$3" # optional
  if [ -z "$exit_code" ]; then
    exit_code=255 # undefined
  fi

  # IMPORTANT(JEFF): nested tmux is a NO OP
  if [ -n "$TMUX" ]; then
    return 1 # EPERM
  fi

  init_existing_session "${session}" "${cwd}" ||
    init_new_session "${session}" "${cwd}" ||
  return "$exit_code"
}

_find_tmux() {
  binpath="$1"
  if [ ! -x "$(which "$binpath")" ]; then
    echo "WARN: Failed to find $binpath..."
    echo
    # NOTE(JEFF): Upon the first failure to find tmux, we pray that this last
    # ditch try may work -- this only applies to when we are using Termux under
    # Android OS.
    if [ -n "$TBIN" ] && [ -n "$THOME" ]; then
      PATH="$TBIN:$THOME/bin:$THOME/local/bin:$PATH"
    else
      # NOTE(JEFF): This is where we would try another method to find tmux...
      echo "CRITICAL: Failed to find $binpath..."
      echo
      return 2 # ENOENT
    fi
  fi
  return 0
}

# NOTE(JEFF): Handle what to do when tmux is not present
_find_tmux tmux

# NOTE(JEFF): No arguments case
# shellcheck disable=SC2181
#if [ $? -ne 0 ]; then
  #usage_text 22 # EINVAL
#fi

while true; do
  case "$1" in
    p|posix|--posix)
      # IMPORTANT(JEFF): This is specifically for complying with how Ghostty
      # handles the default-command configuration.
      _tmux_init "$DEFAULT_SESSION" "$DEFAULT_CWD"
      shift
      ;;
    -v|--version)
      usage_text 0 # OK
      shift
      ;;
    -h|usage|--help)
      usage_text 0 # OK
      shift
      ;;
    --)
      usage_text 0 # OK
      shift
      break
      ;;
    *)
      #false
      # NOTE(JEFF): Handle non-Ghostty terminals by using the same
      # control flow that we are used to!
      _tmux_init "$DEFAULT_SESSION" "$DEFAULT_CWD"
      ;;
  esac
done
