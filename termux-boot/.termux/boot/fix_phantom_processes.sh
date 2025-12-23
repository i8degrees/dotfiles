#!/data/data/com.termux/files/usr/bin/sh
# fix_phantom_processes.sh:jeff
#
# Attempt to resolve the phantom process
# killer on Android 12+
#
# [SOURCE](https://github.com/termux/termux-app/issues/2366)
#

[ -n "$DEBUG_TRACE" ] &&
  set -o xtrace

MAX_PROC=2147483647
PROC_EXISTING_RESULT=$(sudo /system/bin/device_config get activity_manager max_phantom_processes)

echo "CURRENT_MAX_PROC:" "${PROC_EXISTING_RESULT}"

sudo /system/bin/device_config put activity_manager max_phantom_processes "${MAX_PROC}"

PROC_AFTER_RESULT=$(sudo /system/bin/device_config get activity_manager max_phantom_processes)

echo "PROC_AFTER_RESULT:" "${PROC_AFTER_RESULT}"

exit 0

