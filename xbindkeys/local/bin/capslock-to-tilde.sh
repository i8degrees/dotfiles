#!/bin/sh

sleep 1

WINDOW_TARGET="$(xdotool getactivewindow)"

if [ $DEBUG = "1" ]; then
  echo "WT: $WINDOW_TARGET"
fi

ARGS="key --delay 20 --clearmodifiers --repeat 1"
if [ -n "$WINDOW_TARGET" ]; then
  ARGS="$ARGS --window $WINDOW_TARGET"
  echo $ARGS
  xdotool $ARGS grave 
  # xdotool key --window $WINDOW_TARGET --repeat 1 --delay 500 --clearmodifiers grave
else
  xdotool windowactivate $WINDOW_TARGET
  xdotool $ARGS grave
fi
