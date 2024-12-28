#!/usr/bin/env sh

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SHELL="$2" # optional
WORKING_DIR="$1" # optional
#USE_TMUX=1

usage_info() {
  exit_code="$1"
  scr_name="$(basename $0)"

  echo "${scr_name} [working_dir] [shell]"
  echo
  echo "USE_TMUX=<0|1>"
  echo "    where zero (0) executes a shell with an optional working dir path."
  echo "    where zero (1) attempts to attach to an existing"
  echo "    tmux session, else creates a new tmux session."

  if [ -z "$exit_code" ]; then
    exit 0
  else
    exit "$exit_code"
  fi
}

if [ -z "$USE_TMUX" ]; then
  USE_TMUX="1"
fi

if [ -z "$WORKING_DIR" ]; then
  WORKING_DIR="$HOME"
fi

# TODO(JEFF): Add check for tmux binary!

# optional argument; defaults to /bin/bash
if [ -z "$SHELL" ]; then
  if [ -x "/bin/bash" ]; then
    SHELL="/bin/bash"
  elif [ -x "/bin/ash" ]; then
    # NOTE(JEFF): OpenWrt, DD-WRT, FreshTomato
    SHELL="/bin/ash"
  elif [ -x "/bin/busybox" ]; then
    # NOTE(JEFF): OpenWrt, DD-WRT, FreshTomato, Android, iOS
    SHELL="/bin/busybox"
  else # catch all case
    # NOTE(JEFF): My wisdom says that I have rarely encountered
    # a terminal that does not have access to the sh interpreter. Why then,
    # am I uncertain as to whether we should be using /bin/busybox or
    # /bin/sh as the fail safe catch all?
    SHELL="/bin/sh"
  fi
fi

if [ -n "$USE_TMUX" ]; then
  # TODO(JEFF): Should we not try and name our default session?
  tmux attach || tmux new -s default -A
else
  # TODO(JEFF): Do all shell choices support the `-l` and `-c` switches?
  #SHELL_ARGS=(
    #"-l"
    #"-c"
    #"cd"
    #"${WORKING_DIR}"
  #)
  "$SHELL" "-l" "-c" "cd" "${WORKING_DIR}"
fi

