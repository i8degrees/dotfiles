#!/usr/bin/env bash
#
# ZFS operations helper script
#

[ -n "$DEBUG" ] && set -o errexit
[ -n "$DEBUG_TRACE" ] && set -o xtrace

[ -e "$HOME/.bash/lib" ] && . "$HOME/.bash/lib"

# DEPRECATED(JEFF): This function is made obsolete by
# the zstd alias using -T0 to specify an auto-calculated
# number of threads (same as the function). Please use
# the zstd alias instead of this function as this 
# function will be removed in the future.
#
# Use the maximum number of threads for zstd
# (de)-compression.
#
# _zstd(...args)
_zstd() {
  #num_threads="$(($(nproc)-1))"
  num_threads="$(($(nproc)))"
  zstd_args="-T${num_threads}"
  args=$*

  if [ -x "$(exists_exe zstd)" ]; then
    [ -z "$DEBUG" ] && zstd $zstd_args "$args"
    [ -n "$DEBUG" ] && echo zstd $zstd_args "$args"
  else
    echo "ERROR: Failed to find zstd binary..."
    echo
    return 2
  fi
}

# IMPORTANT(JEFF): Use the maximum number of threads 
# detected by zstd for (de)-compression.
[ "$(exists_exe zstd)" ] && alias zstd='zstd -T0'

if [ "$(exists_exe zfs)" ]; then
  alias zfs-mv='zfs rename'
  alias zfs-move='zfs mv'
fi

