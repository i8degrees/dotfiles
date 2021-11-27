#!/bin/bash

rclone_mount() {
  mkdir_bin=$(which mkdir)
  mkdir_params="-p"
  rclone_bin=$(which rclone)
  rclone_params="--allow-other --vfs-cache-mode=writes"

  # FIXME(jeff): We need to ensure that $HOME/Cloud/<rclone-config-name> exists 
  # as well!
  $mkdir_bin $mkdir_params "$HOME/Cloud" || exit 255
  
  $rclone_bin $rclone_params mount "$1" "$2" & 
}

if [ -z "$HOME" ]; then
  echo "${0} - main"
  echo "CRITICAL: This shell script expects the environment to set HOME for us."
  echo 
  exit 255
fi

rclone_mount gdrive_jeffrey-carp:/ "$HOME/Cloud/gdrive/jeffrey-carp"
rclone_mount gdrive_i8degrees:/ "$HOME/Cloud/gdrive/i8degrees"
rclone_mount gdrive_ngirl-dev:/ "$HOME/Cloud/gdrive/ngirl-dev"

rclone_mount dropbox_imbue:/ "$HOME/Cloud/dropbox/imbue"
rclone_mount dropbox_personal:/ "$HOME/Cloud/dropbox/personal"
