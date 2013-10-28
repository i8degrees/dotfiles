#!/bin/sh
#
# Jeffrey Carpenter <jeffrey.carp@gmail.com>
#
#   OS X launchd script for unison mirror 1-way sync to windev
#
# See also,
#
#   launchctl(1), launchd(8), launchd.plist(5)

PWD=$HOME/Projects/hax/nomlib.git

cd $PWD

# Clean up any existing synergys process
#/usr/bin/killall unison

# We hereby turn over primary control to launchd:
# --no-restart and --no-daemon are required for getting along with launchd
unison -socket 7222 -log
# TODO: -log
