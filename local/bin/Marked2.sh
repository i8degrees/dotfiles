#!/bin/sh

ARGUMENTS=$@
MARKED_BIN='/Applications/Marked 2.app/Contents/MacOS/Marked 2'

if [[ $ARGUMENTS ]]; then
  # ARGS=""
  # for arg in $ARGUMENTS; do
  #   ARGS=${ARGS}${arg}
  # done

  # DIR=$(dirname $1)
  # FILE=$(basename $1)
  # /usr/bin/find "${DIR}" -name "${FILE}" -print0 | /usr/bin/xargs -0 "${MARKED_BIN}"

  declare ARGS
  for arg in "$@"
  do
    # ARGS=${arg}${ARGS}
    ARGS+=${arg}
    echo "arg: ${arg}";
  done;

  "$MARKED_BIN" $ARGS
else
  echo "usage: $0 <file>"
  exit -1
fi
