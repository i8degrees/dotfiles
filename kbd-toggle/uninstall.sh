#!/bin/sh
#
# shellcheck shell=bash
#

sudo rm -fv /usr/share/polkit-1/actions/org.local.keyboard.policy
sudo rm -fv /etc/polkit-1/rules.d/49-keyboard-toggle.rules

stow -Dv kbd-toggle

if [ $? = 0 ]; then
  echo "Success! Toggle keyboard script has been installed."
  echo
else
  echo "Error. Try again later."
fi

