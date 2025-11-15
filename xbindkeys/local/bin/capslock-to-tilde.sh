#!/usr/bin/env bash
#
# helper script for user xbindkeys rc file
#

# TODO(JEFF): Consider splitting up xdotool specific bits into a
# library file -- `/scripts.git/lib/x11/` or so?
#
# FIXME(JEFF): kdotool has only partial functionality of xdotool; it
# is missing the key command entirely :-/
#
# FIXME(JEFF): wtype does not like something to do with our virtual
# keyboard setup???

#[signed integer] linux_detect_session_type(void)
#
# ...where the signed integer is one of the following values:
#   -1) unknown
#   1) x11
#   2) wayland
#
# This function depends on the XDG_SESSION_TYPE env variable
# being set globally by your shell.
linux_detect_session_type() {
  res="" # unknown

  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    res="wayland"
  elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
    res="x11"
  else # catch-all for unknown
    true
  fi

  echo "$res"
}

#[string] get_active_window(void)
get_active_window() {
  res=""
  session=$(linux_detect_session_type)

  if [ "$session" = "wayland" ]; then
    res=$(kdotool getactivewindow)
  elif [ "$session" = "x11" ]; then
    res=$(xdotool getactivewindow)
  fi

  echo "$res"
}

#[signed int] key_event(window_id, keysequence, ...keysequence_args)
key_event() {
  cmd="key"
  cmd_buffer=
  #cmd="key" # top-level command
  keysequence_args=("$3") # array of opts for command
  # defaults
  if [ -z "$keysequence_args" ]; then
    #keysequence_args=("--delay" "100")
    true
  fi

  target="$1"
  if [ -z "$target" ]; then
    res=2
    return $res
  fi

  keysequence="$2"
  if [ -z "$keysequence" ]; then
    res=2
    return $res
  fi

  cmd_buffer+=("xdotool" "key")
  cmd_buffer+=("--window" "$target" "${keysequence_args[@]}" "$keysequence")

  #eval "${cmd_buffer[@]}"
  ${cmd_buffer[@]}

  [ -n "$DEBUG" ] && echo "DEBUG: ${cmd_buffer[*]}"
}

WID="$(get_active_window)"

if [ "$DEBUG" = "1" ]; then
  echo "window_id: $WID"
fi

tool_args=(
  "--delay"
  "20"
  "--clearmodifiers"
  "--repeat"
  "1"
)
if [ -n "$WID" ]; then
  #tool_args="$tool_args --window $WID"
  tool_args+=("$WID")
  #echo $wctrl "${tool_args[@]}" grave
  key_event "${tool_args[@]}" grave
  # $wctrl key --window $WID --repeat 1 --delay 500 --clearmodifiers grave
else
  #$wctrl "${tool_args[@]}" grave
  key_event "${tool_args[@]}" grave
fi
