#!/bin/bash
#
# 1. https://github.com/symless/synergy-core/wiki/Core-User-FAQ#what-securityencryption-does-synergy-provide
#

SSH_BIN="$(which ssh)"

# IMPORTANT(JEFF): Always assume that the correct hostname to use is stored
# at /etc/hostname
SERVER_HOSTNAME="scorpio"
#SERVER_HOSTNAME="$(hostname --short)"
SERVER_BIND_ADDR="$SERVER_HOSTNAME:24800"

# Ignore the defaults and use another hostname address
if [ -n "$1" ]; then
  SERVER_HOSTNAME="$1"
fi

echo -e "\tEnvironment\n"
echo -e "Hostname: $SERVER_HOSTNAME\n"
echo -e "Binding: $SERVER_BIND_ADDR\n"

if [ ! -x "$SSH_BIN" ]; then
  echo -e "CRITICAL: Failed to find the ssh binary at $SSH_BIN...\n"
  exit 2
fi

$SSH_BIN -f -N -L 24800:$SERVER_BIND_ADDR "$SERVER_HOSTNAME"

# Now, connect to your Synergy server
#exec synergyc $SERVER_HOSTNAME &

