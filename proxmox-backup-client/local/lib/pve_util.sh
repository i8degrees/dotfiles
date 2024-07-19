#!/usr/bin/env bash
#
# Utility functions for backup-host.sh
#

set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace

# remove inclusion switch from path list
#
# --include-dev <path>\n to <path>\n
# from_proxmox_include(path)
from_proxmox_include() {
  in="$@"
  echo "$in" | sed s/--include-dev/''/ig
}

# remove exclusion switch from path list
# --exclude-dev <path>\n to <path>\n
# from_proxmox_exclude(path)
from_proxmox_exclude() {
  in="$@"
  echo "$in" | sed s/--exclude/''/ig
}

# --include-dev <path>
# to_proxmox_include(path)
to_proxmox_include() {
  buffer=()
  for path in "$@"; do
    buffer+=$(echo "--include-dev $path ")
  done
  echo $buffer
}

# --exclude-dev <path>
# to_proxmox_exclude(path)
to_proxmox_exclude() {
  buffer=()
  for path in "$@"; do
    buffer+=$(echo "--exclude $path ")
  done
  echo $buffer
}
