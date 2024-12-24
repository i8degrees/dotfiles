#!/usr/bin/env bash

# TMSU_DB=$HOME/Pictures/.tmsu/db

function log_debug() {
  if [[ $DEBUG -eq 1 ]]; then
    echo "DEBUG(jeff): $@"
  fi
}

function log_info() {
  echo "INFO(jeff): $@"
}

function run_command() {
  log_debug $@
  exec $@
}

ARGS=()
ARG_INDEX=1
for (( i=1; i <= "$#"; i++ )); do
  ARG_INDEX=$i
  ARGS+=" ${!i}"

  log_debug "${ARG_INDEX}"
  log_debug "${ARGS}"
done

if [[ $ARG_INDEX -le 1 ]]; then
  log_info tmsu tag $ARGS
  log_info "tmsu requires at least one tag"
  exit 255
fi

# tmsu delete <filename> <tags>
run_command "tmsu delete $ARGS"

exit 0
