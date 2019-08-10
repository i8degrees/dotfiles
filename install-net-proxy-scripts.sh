#!/usr/bin/env bash

if [[ -e /etc/network && /etc/network/if-up.d ]]; then
  sudo install ./net-scripts/network/if-up.d/proxy /etc/network/if-up.d/proxy
fi

if [[ -e /etc/network && /etc/network/if-down.d ]]; then
  sudo install ./net-scripts/network/if-down.d/proxy /etc/network/if-down.d/proxy
fi
