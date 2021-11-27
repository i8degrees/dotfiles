#!/bin/sh

PWD="${HOME}/.config/rclone"

echo "INFO: Remounting rclone drives..."
echo

${PWD}/umount.sh || echo "The script umount.sh has failed with exit code $?"; exit 255
${PWD}/mount.sh || echo "The script mount.sh has failed with exit code $?"; exit 255

echo "All done!"
echo
