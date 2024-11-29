#!/usr/bin/env bash
#
#

BOOL_ARG="$1"

if [ "$BOOL_ARG" = "" ]; then
  declare result
  toggle_result=$(synclient -l|grep TouchpadOff)
  if [[ "$toggle_result" =~ "0" ]]; then
    result=1
  else
    result=0
  fi
  synclient TouchpadOff="$result" ClickPad="$result"
else
  synclient TouchpadOff="${BOOL_ARG}" ClickPad="$result"
fi

