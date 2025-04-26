#!/bin/sh
#

[ -n "$(command -v zstd)" ] && alias zstd='zstd -T4'
[ -n "$(command -v zfs)" ] && alias zfs-mv='zfs rename'
[ -n "$(command -v zfs)" ] && alias zfs-move='zfs mv'

