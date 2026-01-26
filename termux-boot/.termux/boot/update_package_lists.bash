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

list_all_packages() {
  run_args=("-l")

  dest_path="$1"
  if [ -z "$dest_path" ]; then
    echo "ERROR: Missing script parameter."
    echo
    return 2 # ENOENT
  fi

  [ -x "$(which dpkg)" ] &&
    dpkg "${run_args[@]}" > "${dest_path}"
}

# Dump only the packages where the end-user
# explicitly installed it -- one package per line.
#
# TODO(JEFF): Handle sorting options; we want
# to be able to transform the default one package
# per newline list to all packages in one line
# format so we can easily add apt install in front
# of it for when we must re-install our shell env
# from scratch.
list_user_packages() {
  run_args=("showmanual")

  dest_path="$1"
  if [ -z "$dest_path" ]; then
    echo "ERROR: Missing script parameter."
    echo
    return 2 # ENOENT
  fi

  sorting_opts="$2"
  if [ -z "${sorting_opts}" ]; then
    sorting_opts=
  fi

  if [ "${sorting_opts}" = "all-one" ]; then
    # TODO(JEFF): Impl
    [ -x "$(which apt-mark)" ] &&
      apt-mark "${run_args[@]}" > "${dest_path}"
  else # catch-all is one package per newline
    [ -x "$(which apt-mark)" ] &&
      apt-mark "${run_args[@]}" > "${dest_path}"
  fi
}

# stow -Rv bash
# FIXME(JEFF): Consider relocating this stow package to termux-boot?
[ -r "$HOME/.bash/aliases.d/termux.sh" ] &&
  . "$HOME/.bash/aliases.d/termux.sh"

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

list_all_packages "${DEST_PREFIX}/installed_packages.list"

list_user_packages "${DEST_PREFIX}/installed_packages.userlist"

exit 0

