#!/bin/bash

JAVA_BIN=$(which java)

if [[ ! ( -x "${JAVA_BIN}") ]]; then
  echo "CRITICAL: Java JRE must be installed for abe."
  exit 1
fi

if [ -z "${1}" ]; then
  echo "CRITICAL: The first argument must be an existing ADB file."
  echo
  exit 1
fi

if [ -z "${2}" ]; then
  echo "CRITICAL: The second argument must be a path to the output file."
  echo
  exit 1
fi

if [ -x "${HOME}/local/bin/abe.jar" ]; then
  java -jar "${HOME}/local/bin/abe.jar" unpack "${1}" "${2}" 
fi

exit 0
