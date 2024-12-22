#!/bin/sh

log_debug() {
  echo "DEBUG(jeff): ${1}."
  echo
}

log_info() {
  echo "INFO(jeff): ${1}."
  echo
}

key_action() {
  EXEC="xdotool key $1 grave"
  if [ "$DEBUG" = "1" ]; then
    log_debug "Executing..."
    printf "\t"
    echo "${EXEC}"
  fi

  $EXEC
}

if [ "$DEBUG" = "1" ]; then
  log_debug "Debug mode is toggled ON."
  log_debug "Sleeping for one (1) second... zZz!"
  sleep 1
fi

WINDOW_ID="$(xdotool getactivewindow)"

if [ "$DEBUG" = "1" ]; then
  log_debug "Locked on target at window ${WINDOW_ID}."
fi

xdotool windowactivate "${WINDOW_ID}"

ARGS="--delay 0 --repeat-delay 20 --repeat 1 --clearmodifiers"

if [ -n "${WINDOW_ID}" ]; then
  key_action "${ARGS}"
fi
