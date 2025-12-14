#!/bin/sh
# update_package_lists.sh:jeff
#
# Store a human readable copy of our installed
# packages via Termux on bootup -- before 
# user auth
#

# FIXME(JEFF): Fix paths

DEST_PREFIX="${TERMUX_USER_NOTES}/jeff_pixel4a5g"
if [ ! -d $DEST_PREFIX ]; then
  echo "CRITICAL: Destination path does not exist - exiting."
  echo
  exit 2
fi

# TODO(JEFF): Review dpkg && apt notes for more
# features, i.e. de-duplication of package lists
dpkg -l > \
  "${DEST_PREFIX}/installed_packages.md"

