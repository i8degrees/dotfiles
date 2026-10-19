#!/bin/sh
#
# shellcheck shell=bash
#

sudo install -o root -g root actions/org.local.keyboard.policy /usr/share/polkit-1/actions/org.local.keyboard.policy
sudo install -o root -g root rules/49-keyboard-toggle.rules /etc/polkit-1/rules.d/49-keyboard-toggle.rules

stow -Rv kbd-toggle

if [ $? = 0 ]; then
  echo "Success! Toggle keyboard script has been installed."
  echo
else
  echo "Error. Try again later."
fi

