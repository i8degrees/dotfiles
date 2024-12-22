#!/bin/sh


XDG_MOUNT_TAGS_DIRS="$XDG_MOUNT_TAGS:/mnt/jeff/tags:/tags"
XDG_MOUNT_DIR="/tags" # =${XDG_MOUNT_TAGS_DIRS}[2]

export XDG_MOUNT_TAGS_DIRS
export XDG_MOUNT_DIR
