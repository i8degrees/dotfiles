#!/usr/bin/env bash
#
# This custom hook file is for use with `/root/local/bin/backup-host.sh` --
# a systemd service and shell script for `proxmox-backup-client` that
# operates with file-based disk images.
#
# This is the "post" backup hook and will be ran after the backup call to
# `proxmox-backup-client` has been completed.
#

if [ -n "$DEBUG" ]; then
  set -o errexit
fi

[ -e "$HOME/.config/proxmox-backup/pbs1.password" ] && source "$HOME/.config/proxmox-backup/pbs1.password"

# IMPORTANT(JEFF): The path must NOT end with a trailing path delimiter, i.e.:
# a `/` character!
DEST_DIR="/data/metadata"
if [[ ! (-d "$DEST_DIR") ]]; then
  echo "CRITICAL: Failed to locate the dump directory at ${DEST_DIR}..."
  echo
  exit 2
fi

POOL_NAME="boot-pool"
BOOT_POOL_DEV=/dev/vda
if [[ ! (-b "$BOOT_POOL_DEV") ]]; then
  echo "CRITICAL: Failed to find the boot-pool device node at ${BOOT_POOL_DEV}..."
  echo
  exit 2
fi

if [ "$REMOVE_FILE_METADATA" = "1" ]; then
  echo rm -rf "${DEST_DIR}/ncdu.json.gz"
  echo rm -rf "${DEST_DIR}/${POOL_NAME}.hist
  echo rm -rf "${DEST_DIR}/${POOL_NAME}.sgdisk"
  echo rm -rf "${DEST_DIR}/${POOL_NAME}.parts"
  echo rm -rf "${DEST_DIR}"
fi

#echo "Success! Collected disk metadata for ${POOL_NAME} at ${DEST_DIR}..."
echo "Success! This is the post-hook end of script. Goodbye!"
exit 0

