#!/usr/bin/env bash

if [[ -e /etc/network/if-up.d/proxy ]]; then
  sudo rm -rfv /etc/network/if-up.d/proxy
fi

if [[ -e /etc/network/if-down.d/proxy ]]; then
  sudo rm -rfv /etc/network/if-down.d/proxy
fi
