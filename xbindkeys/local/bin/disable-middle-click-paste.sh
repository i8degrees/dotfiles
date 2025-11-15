#!/bin/bash
#
# xbindkeys utility script
#
# IMPORTANT(JEFF): This script requires the following dependencies;
# a) xsel (*) or xclip
# b) killall; returns exit code 251 upon missing path
# c) xbindkeys; exit code 252 indicates missing path
# d) xdotool; exit code 253 from this script indicates missing path
#
# TODO(JEFF): verify what package name(s) `c` is typically bundled together
# with
#

# the console output function must not mutate the input by adding newline
# characters; `echo -n` is undefined behavior on "POSIX" SH and thus...
echo -n | {
  xsel -n -i || { xclip -silent -i; }
}; killall -HUP xbindkeys;

xdotool click 2

# reload configuration
#killall -HUP xbindkeys || exit 251
