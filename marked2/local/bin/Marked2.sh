#!/bin/bash
#
# 2016-02/15:jeff
#
# Markdown file output to Marked, a fancy OS X Markdown renderer
#
#   See also,
# Marked.sublime-build

# Range is from 0 (no debug) .. 1 (debug output)
NOM_BASH_DEBUG=1
NUM_ARGUMENTS=$#
MARKED_BIN="/Applications/Marked 2.app/Contents/MacOS/Marked 2"

if [[ $NUM_ARGUMENTS -lt 1 ]]; then
  echo "usage: $0 <file>"
  exit 0
else
  # Save the current IFS environment here, so we can modify the way Bash
  # handles file path interpretations...
  SAVE_IFS=$IFS
  ARGUMENTS=$*

  # IMPORTANT(jeff): Reset $IFS to ignore white space, so that spaces are not
  # interpreted as separate arguments. We have to deal with spaces, parenthesis
  # and other annoyances -- Sublime Text's QuickSimpleNote plugin adds insult
  # to injury by throwing parenthesis in there for us, too!
  #
  # A sample file path looks like this:
  # ./Packages/QuickSimplenote/temp/ntoe.md (00c6d417c9234c6ab109bb8b7c1e2774)
  IFS=$(echo -en "\n\b")

  if [[ ${NOM_BASH_DEBUG} -gt 0 ]]; then
    echo "NUM_ARGUMENTS: ${NUM_ARGUMENTS}"
    echo "\"${MARKED_BIN}\" \"${ARGUMENTS}\""
  fi

  "${MARKED_BIN}" "${ARGUMENTS}"

  # Restore $IFS environment
  IFS=$SAVE_IFS
fi

