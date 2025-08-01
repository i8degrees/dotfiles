#!/bin/bash
#
#

if [ ! -x "$(which ssh)" ]; then
  echo "CRITICAL: Failed to find ssh binary..."
  echo
  exit 2 # ENOENT 
fi

# IMPORTANT(JEFF): This environment must be passed by getty@tty4.service so
# that we do not reach this flow under normal circumstances!
if [ "$USE_SSH_LOGIN_TTY" = 1 ]; then
  TMPDIR=/tmp
  HOME="/home/$USER"
  PATH="$HOME/bin:/usr/bin:/bin"

  TIMEOUT=1
  # TODO(JEFF): We have yet to implement the use of this "failure count"..?
  RETRIES_FAIL=2
  RETRIES_COUNTER=0

  SSH_HOSTS=(
    "pve3.home"
    "pve3-wifi.home"
  )
  PING_ARGS=(
    "-4"
    "-w${TIMEOUT}"
  )

  HOST="${SSH_HOSTS[0]}"
  if ! ping "${PING_ARGS[@]}" "${SSH_HOSTS[0]}"; then
    HOST="${SSH_HOSTS[1]}"
    RETRIES_COUNTER=$(($RETRIES_COUNTER+1))
  elif ! ping "${PING_ARGS[@]}" "${SSH_HOSTS[1]}"; then
    HOST="${SSH_HOSTS[2]}"
    RETRIES_COUNTER=$(($RETRIES_COUNTER+1))
  fi

  SSH_HOST="${USER}@${HOST}"

  ssh "${SSH_HOST}"; echo "retry_count: $RETRIES_COUNTER" && sleep 2s && exit 0
fi
