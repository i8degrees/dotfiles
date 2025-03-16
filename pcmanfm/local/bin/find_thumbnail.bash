#!/usr/bin/env bash
#
# Find thumbnails
#
# 1. https://askubuntu.com/questions/1084640/where-are-the-thumbnails-of-a-new-image-located
#

#[ "$DEBUG_TRACE" = "2" ] && set -o xtrace

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

find_thumbnail() {
  full_path="file://$(realpath -s "$1")"
  md5name=$(printf %s "${full_path// /%20}" | md5sum)

  find ~/.thumbnails/ ~/.cache/thumbnails/ \
    -name "${md5name%% *}.png" 2> /dev/null
}

ARGS=$1

if [ -z "$1" ]; then
  echo "CRITICAL: Missing script argument (file path)..."
  echo
  exit 255
fi

find_thumbnail "$ARGS"
