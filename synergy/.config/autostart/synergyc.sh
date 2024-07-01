#!/bin/sh
#
# This script is for use with synergyc.service user script
#
# This script should be installed at your user's ~/.config/autostart path
# and setup as an autostart script upon login.
#

# jeff ALL=(ALL) NOPASSWD: /bin/killall synergyc
sudo killall synergyc

# systemctl --user enable synergyc.service && systemctl --user start synergyc
systemctl --user restart synergyc
