#!/bin/sh
#
# Jeffrey Carpenter <jeffrey.carp@gmail.com>
#
#   OS X launchd script for unison mirror 1-way sync to windev
#
# See also,
#
#   launchctl(1), launchd(8), launchd.plist(5)

PWD=$HOME/Projects/third-party

cd $PWD

unison -socket 7225 -log
