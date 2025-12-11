#!/bin/sh
#
# Create virtual multi-output "surround sound" at login
#
# SEE ALSO
# 1. linux `paprefs` package; this is what I would
# ordinary use -- this is not an option here.
#

exit 0
# DEPRECATED(JEFF): This is now tried in ~/.config/pulse/defaults.pa
pactl load-module module-combine-sink sink_name=combined_monitor_sink slaves=alsa_output.pci-0000_01_00.1.hdmi-stereo-extra3,alsa_output.pci-0000_03_00.0.analog-stereo \
    channels=2 channel_map=front-left,front-right

pactl set-default-sink combined_monitor_sink

