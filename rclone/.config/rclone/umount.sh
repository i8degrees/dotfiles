#!/bin/bash

rclone_unmount() {
  unmount_bin=$(which mount)
  mount_path=$1
  sudo_bin=$(which sudo)

  if [[ -z "${mount_path}" ]]; then
    echo "${0} - rclone_unmount"
    echo "CRITICAL: A mounted path must be given."
    echo
    exit 1
  fi

  fusermount_bin=$(which fusermount)
  if [ -x "${fusermount_bin}" ]; then
    $fusermount_bin -u "${mount_path}"
  else
    $sudo_bin "${unmount_bin}" "${mount_path}"
  fi
}

if [ -z "$HOME" ]; then
  echo "${0} - main"
  echo "CRITICAL: This shell script expects the environment to set HOME for us."
  echo 
  exit 255
fi

rclone_unmount "$HOME/Cloud/dropbox/personal"
rclone_unmount "$HOME/Cloud/dropbox/imbue"
rclone_unmount "$HOME/Cloud/gdrive/jeffrey-carp"
rclone_unmount "$HOME/Cloud/gdrive/i8degrees"
rclone_unmount "$HOME/Cloud/gdrive/ngirl-dev"

