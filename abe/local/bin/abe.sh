#!/usr/bin/env bash

function run_command() {
  if [[ -n "$DRY_RUN" ]]; then
    echo "DEBUG: $*"
    # echo "exec ${1}"
  else
    $@ # exec "$@"
  fi
}

function usage_info() {
  declare SCRIPT_NAME
  SCRIPT_NAME=${0}

  echo "$SCRIPT_NAME <input> <output>"
  echo
  echo "${SCRIPT_NAME} extracts the files inside of an adb backup"
  echo
  echo "  where input is an existing backup file in the adb format"
  echo "  where output is an existing absolute path to the resulting tar file"
  echo

  if [[ -n "$1" ]]; then
    echo "$1"
  fi

  exit 0
}

ABE_BIN="${HOME}/local/bin/abe.jar"
JAVA_BIN="$(command -v java)"

if [[ ! ( -x "${JAVA_BIN}") ]]; then
  usage_info "CRITICAL: A Java JRE must be installed for the operation of abe."
  exit 1
fi

if [ -z "${1}" ]; then
  usage_info "CRITICAL: The first argument must be an existing ADB file."
  exit 1
fi

if [ -z "${2}" ]; then
  usage_info "CRITICAL: The second argument must be a path to the output tar file."
  exit 1
fi


if [[ -f "${ABE_BIN}" ]]; then
  run_command "$JAVA_BIN" "-jar ${ABE_BIN}" "unpack" "${1}" "${2}"
  exit 0
else
  echo "CRITICAL: The abe executable at ${ABE_BIN} does not exist."
  exit 255
fi
