#!/bin/sh
#
# Jeffrey Carpenter <1329364+i8degrees@users.noreply.github.com>
#
#   OS X launchd script for synergys control (http://www.synergy-foss.org)
#
# See also,
#
#   launchctl(1), launchd(8), launchd.plist(5)
#

SYNERGYS_BIN=$(which synergys)

# This path must be readable by the user launching this service script
SYNERGY_CFG=$HOME/.synergy.conf

# This path must be writable by the user launching this service script if you
# care for logging -- this should not interrupt the daemon startup process if it
# fails...
LOG_FILEPATH=$HOME/.synergy/synergy.log
LOG_LEVEL=DEBUG # See synergys --help for acceptable parameters

# Listen on all interfaces with the default port assignment
#HOSTNAME=$(hostname)
HOSTNAME=$(hostname -s)
BIND_ADDR=":24800" 
#BIND_ADDR="127.0.0.1:24800"

# Clean up any existing synergys process
/usr/bin/killall -9 synergys

SYNERGY_ARGS="--no-restart --no-daemon --name $HOSTNAME --config $SYNERGY_CFG --address $BIND_ADDR --log $LOG_FILEPATH --debug $LOG_LEVEL"
# We hereby turn over primary control to launchd:
# --no-restart and --no-daemon are required for getting along with launchd

#$SYNERGYS_BIN --no-daemon --config $SYNERGY_CFG
# shellcheck disable=SC2086
"$SYNERGYS_BIN" $SYNERGY_ARGS

