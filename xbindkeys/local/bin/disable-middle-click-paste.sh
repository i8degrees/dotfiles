#!/bin/bash
#
# xbindkeys utility script
#
# IMPORTANT(JEFF): This script requires the following dependencies;
# 1. xsel (*) or xclip
# 2. pkill && killall; returns exit code 251 upon missing path
# 3. xbindkeys; exit code 252 indicates missing path
# 4. xdotool; exit code 253 from this script indicates missing path
#
# TODO(JEFF): verify what package name(s) `2` is bundled with
#check_deps ("xsel" "xclip" "pkill" "killall" "xbindkeys" "xdotool")

# TODO(JEFF): This script is quite possibly broken on X11 and thus needs to be
# tested on virgo...
if [ "${XDG_SESSION_TYPE}" = "x11" ]; then
  # the console output function must not mutate the input by adding newline
  # characters; `echo -n` is undefined behavior on "POSIX" SH and thus...
  echo -n | {
    xsel -n -i || { xclip -silent -i; }
  }; killall -HUP xbindkeys;

  xdotool click 2
elif [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
  # IMPORTANT(JEFF): This script is obsolete now when inside of a Wayland
  # session as there are new APIs present that can auto-magically handle this.
  exit 1
fi

