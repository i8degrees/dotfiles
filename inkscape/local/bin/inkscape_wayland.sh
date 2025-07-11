#!/bin/sh
#
# Restore Inkscape's menu when using the Global Menu feature under Wayland.
#
# SEE ALSO
# 1. [credit](https://www.reddit.com/r/kde/comments/1g2rojk/comment/m2ofh8f/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
#

#PATH=/usr/bin:/usr/local/bin:$PATH

export "$(dbus-launch)" && /usr/bin/inkscape "$@"

