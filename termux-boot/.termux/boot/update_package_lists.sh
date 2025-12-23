#!/data/data/com.termux/files/usr/bin/bash
# update_package_lists.sh:jeff
#
# Store a human readable copy of our installed
# packages via Termux on bootup -- after user
# authentication
#
# shellcheck shell=bash
#
# TODO(JEFF): Review dpkg && apt notes for more
# an improved implementation of our package update
# function; de-duplication and other useful 
# manipulations.

# TODO(JEFF): Once we have a better grip on the 
# Termux init scripts, we ought to be able to replace
# the sourcing of ~/.aliases bits with a lightweight
# variant that does not end up doing a full shell env
# init.

update_packages_list() {
  dpkg_args=("-l")

  dest_path="$1"
  if [ -z "$dest_path" ]; then
    echo
    echo
    return 2
  fi

  dpkg "${dpkg_args[@]}" > "${dest_path}"
}

if [ -n "$THOME" ]; then
  echo "INFO: THOME env has been initialized."
  echo
  [ -r "$THOME/.aliases" ] &&
    . "$THOME/.aliases"
else
  echo "INFO: THOME env has not been initialized."
  echo
  [ -r "${HOME}/.aliases" ] &&
    . "${HOME}/.aliases"
fi

if [ -z "$TERMUX_USER_NOTES" ]; then
  echo "CRITICAL: TERMUX_USER_NOTES env has not been initialized."
  echo
  exit 22
fi

#if [ ! exists_path "$DEST_PREFIX" ]; then
DEST_PREFIX="${TERMUX_USER_NOTES}/jeff_pixel4a5g"
if [ ! -d "$DEST_PREFIX" ]; then
  # NOTE(JEFF): If this path does not exist, chances are
  # that the git repo does not yet exist, or we have
  # renamed the sub-directory -- jeff_pixel4a5g --
  # and forgotten all about this script!
  if [ -n "$DEBUG" ]; then
    echo "DEBUG:" "${TERMUX_USER_NOTES}"
    echo
    echo "DEBUG:" "${DEST_PREFIX}"
    echo
  fi

  echo "CRITICAL: Destination path does not exist - exiting."
  echo
  exit 2
fi

update_packages_list "${DEST_PREFIX}/installed_packages.md"

exit 0

