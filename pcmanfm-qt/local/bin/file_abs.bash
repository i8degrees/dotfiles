#!/usr/bin/env bash
#
# Find thumbnails
#
# 1. https://askubuntu.com/questions/1084640/where-are-the-thumbnails-of-a-new-image-located
#

set -o pipefail
[ -n "$DEBUG" ] && set -o errexit
[ -n "$DEBUG_TRACE" ] && set -o xtrace

# sed
REGEXP_STR="s/^file:\\/\\/\\//\\//"

usage() {
  SCRIPT_NAME="$(basename $0)"

  echo "Usage"
  echo "====="
  echo "$SCRIPT_NAME" "/path/to/file.bmp"
  echo "$SCRIPT_NAME" "~/Pictures/file.jpg"
  echo "$SCRIPT_NAME" "file.jpg"
  echo "$SCRIPT_NAME" ""file with spaces.tif""
  echo
}

# Check given path for the usage of `file:///`. An absolute filesystem path
# always follows the syntax.
#
# NOTE(JEFF): This is a prefix string defined by some Free Desktop spec...
#parse_path() {
  #INPUT_STR="$1"
  #if [ -z "$INPUT_STR" ]; then
    #echo "ERROR: Missing function argument..."
    #echo
    #return 2
  #fi

  #echo "$INPUT_STR" | sed "s/^file:\\/\\/\\//\\//"
#}

to_abs() {
  INPUT_STR="$1"
  if [ -z "$INPUT_STR" ]; then
    echo "ERROR: Missing function argument..."
    echo
    return 2
  fi

  echo "$INPUT_STR" | sed "s/^file:\\/\\/\\//\\//"
}

from_abs() {
  INPUT_STR="$1"
  if [ -z "$INPUT_STR" ]; then
    echo "ERROR: Missing function argument..."
    echo
    return 2
  fi

  echo file:///$INPUT_STR
}

ARGS=$1

if [ -z "$1" ]; then
  echo "CRITICAL: Missing script argument (file path)..."
  echo
  exit 255
fi

to_abs "$ARGS"
from_abs "$ARGS"
