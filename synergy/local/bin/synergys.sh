#!/bin/bash
#
# Jeffrey Carpenter <i8degrees@gmail.com>
#
#   OS X launchd script for synergys control (http://www.synergy-foss.org)
#
# See also,
#
#   launchctl(1), launchd(8), launchd.plist(5)

SYNERGYS_BIN=$(which synergys)

# This path must be readable by the user launching this service script
SYNERGY_CFG=/Users/jeff/.synergy.conf

# This path must be writable by the user launching this service script if you
# care for logging -- this should not interrupt the daemon startup process if it
# fails...
#LOG_FILEPATH=$HOME/.synergy/synergy.log
#LOG_LEVEL=INFO # See synergys --help for acceptable parameters

HOSTNAME=$(hostname -s) # Short hostname
IP_PORT=":24800" # Listen on all interfaces with the default port for synergys

# Clean up any existing synergys process
/usr/bin/killall -9 synergys

# We hereby turn over primary control to launchd:
# --no-restart and --no-daemon are required for getting along with launchd
#$SYNERGYS_BIN --no-daemon --config $SYNERGY_CFG
$SYNERGYS_BIN --no-restart --no-daemon --name $HOSTNAME --config $SYNERGY_CFG --address $IP_PORT
# TODO: --debug $LOG_LEVEL --log $LOG_FILEPATH
