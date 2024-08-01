#!/usr/bin/env bash
#
# This custom hook file is for use with `/root/local/bin/backup-host.sh` --
# a systemd service and shell script for `proxmox-backup-client` that
# operates with file-based disk images.
#
# This is the "pre" backup hook and will be ran before any calls to
# proxmox-backup-client have been made. This allows us the opportunity
# to collect important metadata regarding this host, such as its
# partition table and ZFS history.
#

if [ -n "$DEBUG" ]; then
  set -o errexit
fi

# IMPORTANT(JEFF): The path must NOT end with a trailing path delimiter, i.e.:
# a `/` character!
TMP_DIR=/tmp
if [ -n "$TMPDIR" ]; then
  TMP_DIR=$TMPDIR
fi

# IMPORTANT(JEFF): The path must NOT end with a trailing path delimiter, i.e.:
# a `/` character!
DEST_DIR="/data/metadata"

if [[ ! (-d "$DEST_DIR") ]]; then
  mkdir -p "$DEST_DIR" || exit 254
fi

POOL_NAME="boot-pool"
BOOT_POOL_DEV=/dev/vda
if [[ ! (-b "$BOOT_POOL_DEV") ]]; then
  echo "CRITICAL: Failed to find the boot-pool device node at ${BOOT_POOL_DEV}..."
  echo
  exit 2
fi

echo "Collecting disk metadata for ${POOL_NAME}..."
echo

if [ -x "$(command -v gdisk)" ]; then
  echo "Storing a human-readable copy of the partition table..."
  echo
  gdisk -l "$BOOT_POOL_DEV" > "${DEST_DIR}/${POOL_NAME}.parts"
else
  echo "Failed to find gdisk. Skipping..."
  echo 
fi

if [ -x "$(command -v sgdisk)" ]; then
  echo "Storing a binary copy of the partition table..."
  echo
  { sgdisk --backup="${DEST_DIR}/${POOL_NAME}.sgdisk" "$BOOT_POOL_DEV" > "/dev/null" ;} 2>&1
else
  echo "Failed to find sgdisk. Skipping..."
  echo
fi

if [ -x "$(command -v zpool)" ]; then
  echo "Storing the complete ZFS pool history record for ${POOL_NAME}..."
  echo
  zpool history "${POOL_NAME}" > "${DEST_DIR}/${POOL_NAME}.hist"
else
  echo "Failed to find zpool. Skipping..."
  echo
fi

NCDU_ARGS="--extended" 
NCDU_EXCLUSIONS=(
  --exclude-kernfs
  --exclude /home/jeff
  --exclude /home/acme
  --exclude /media
  --exclude /mnt 
)

if [ -x "$(command -v ncdu)" ]; then
  echo "Storing file metadata attributes for ${POOL_NAME} as JSON..."
  echo
  ncdu "${NCDU_EXCLUSIONS[@]}" "$NCDU_ARGS" -o "${TMP_DIR}"/.ncdu.json /
  gzip "${TMP_DIR}"/.ncdu.json && cp -av "${TMP_DIR}"/.ncdu.json.gz "${DEST_DIR}/ncdu.json.gz"
  rm -rf "${TMP_DIR}/.ncdu.json.gz"
  rm -rf "${TMP_DIR}/.ncdu.json"
else
  echo "Failed to find ncdu. Skipping..."
  echo
fi

if [ -x "$(command -v apt-mark)" ]; then
  echo "Generating post-installation package list with apt-mark..."
  echo
  apt-mark showmanual > "${DEST_DIR}/packages.postinstalled"
else
  echo "Failed to find apt-mark. Skipping..."
  echo
fi

if [ -x "$(command -v sort)" ] && [ -x "$(command -v zgrep)" ] && [ -f "/var/log/apt/history.log" ]; then
  echo "Generating command-line history of apt-get system calls made..."
  echo
  zgrep -i "Commandline" /var/log/apt/history.log* > "${TMP_DIR}"/packages.history
  sort -r ${TMP_DIR}/packages.history > "${DEST_DIR}/packages.history"
  rm -rf "${TMP_DIR}/packages.history"
else
  echo "Failed to find zgrep or /var/log/apt/history.log. Skipping..."
  echo
fi

METADATA_README="$HOME/local/share/proxmox-backup/${POOL_NAME}.md"
if [ -e "$METADATA_README" ]; then
  echo "Found ${METADATA_README}. Copying this file to ${DEST_DIR}..."
  echo
  cp -av "${METADATA_README}" "${DEST_DIR}"
fi

echo "Success! Collected disk metadata for ${POOL_NAME} at ${DEST_DIR}..."
exit 0

