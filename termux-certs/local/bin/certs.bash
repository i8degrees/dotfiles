#!/data/data/com.termux/files/usr/bin/bash
# termux-certs/local/bin/certs.bash:jeff
# 
# User Trusted Certificate Authority Roots
#
# Helper script for management of my privately
# ran PKI infra at acme.fs1.home.
#
# NOTE(JEFF): This package requires several stow
# packages from my [dotfiles][dotfiles.git]
# to be setup: bash, termux, termux-certs.
# Additionally, you will need stow (Perl), git
# and git-lfs binaries installed via Termux or
# so.
#
# TODO(JEFF): Extend this script to be usable
# on any (non-Windows) platform, such as our
# servers (Linux) and lastly, our desktop systems 
# (MacOS, Linux).
#
# [dotfiles.git]: https://github.com/i8degrees/dotfiles.git

[ -r "$HOME/.bash/lib" ] &&
. "$HOME/.bash/lib"

# TODO(JEFF): Attempt to add `.` to extension if
# the given input does not have one?
append_extension() {
  ext="$1"
  dest_path="$2"
  if [ -z "$ext" ] || [ "$ext" = "" ]; then
    return 2 # ENOENT
  fi

  result=$(basename -s "$ext" "$dest_path")

  echo "$result"
}

link_path() {
  prefix="$1"
  dest_path="$2"

  ln -sf "$prefix" "${dest_path}"
}

# TODO(JEFF): Implement the use of cp when rsync is not found
#
# Copy a file from a given source path to its specified 
# path. Said paths must both be valid (POSIX) filesystem paths
# as defined by the operating system.
#
# returns 2 - missing script parameter; a relative or absolute filesystem 
# path, no longer than 255 bytes
# returns 0 - success
#
#signed int copy_file(prefix = string, dest = string, opts = null)
copy_file() {
  prefix="$1"
  if [ -z "${prefix}" ]; then
    echo "ERROR: Missing script parameter - prefix (filesystem path)."
    echo
    return 2
  fi

  dest_path="$2"
  default_params=("-avPu")

  # TODO(JEFF): Implement the use of cp when rsync is not found
  #
  # WARNING(JEFF): This call fails under an Android shell due to
  # the lack of shell init for the root superuser -- unless
  # the TBIN value is present during sudo request.
  if [ -n "$TBIN" ] && [ -d "$TBIN" ]; then
    "$TBIN/rsync" "${default_params[$*]}" "${prefix}" "${dest_path}"
  else
    rsync "${default_params[$*]}" "${prefix}" "${dest_path}"
  fi
}

#CWD="$2"
if [ -n "$TERMUX_USER_CA" ]; then
  CWD="$TERMUX_USER_CA"
else
  CWD="$HOME/.certs"
fi

if [ ! -d "$TERMUX_USER_CA" ]; then
  exit 2
fi

# source of truth
PREFIX="${CWD}/pem"
NUM_FILES=$(ls -1 "${PREFIX}" | wc -l)
for filename in $(ls -1 "${PREFIX}"); do
  #echo "${filename}"
  dest_filename=$(append_extension ".crt" "${TERMUX_USER_CA}"/"${filename}")
  echo $dest_filename
  # TODO(JEFF): Add error handling here and subtract
  # unsuccessful links from the NUM_FILES tracking var.
  link_path \
    "${CWD}/pem/${filename}" \
    "${CWD}/${dest_filename}"
done

if [ "$NUM_FILES" -ge 1 ]; then
  echo "INFO: Linked ${NUM_FILES} file(s) to ${CWD}."
fi

exit 0

DEST_CA_PATH=
if [ -n "$TERMUX_SYSTEM_CA" ]; then
  DEST_CA_PATH="$TERMUX_SYSTEM_CA"
else
  echo "CRITICAL: Failed to find global env - TERMUX_SYSTEM_CA."
  echo
  exit 255
fi

if [ ! -d "$TERMUX_SYSTEM_CA" ]; then
  echo "CRITICAL: Failed to find global path (dir) - ${TERMUX_SYSTEM_CA}."
  echo
  exit 2
fi

# TODO(JEFF): We must diff DER encoded certificates from PEM encoding,
# thus we shall use `file -i $filename | grep charset=binary` in order
# to do so.
#
# 1. (if "binary") openssl x509 -inform DER -outform PEM -in example.crt -out example.crt
# 2. (else) openssl x509 -noout -text -fingerprint -in example.crt >> example.crt
# 3. The correct format for the resulting cert is the PEM base64 encoding
# followed by the human-readable ASCII text below it.
# 4. mv -v example.crt "$(openssl x509 -subject_hash_old -noout -in example.crt)".0
# 'example.crt' -> '829893ef.0'
# 5. cp -v *.0 $TERMUX_SYSTEM_CA/cacerts-custom
# 6. print to console requesting that the user restarts the device.
# 7. Profit (!) $$$
#
# TODO(JEFF): We must add OS detection around this area
# in order to prevent execution of Android specific steps;
# I am thinking that we could split these tasks up into
# mulitple bash scripts that are OS dependent.

# TODO(JEFF): Consider detection of Magisk and/or the correct module
# before we bother with this step?
USERID="$(id -u)"
if [ "${USERID}" = 0 ]; then
  copy_file "${CWD}/*.crt" "${DEST_CA_PATH}"
else
  echo "ERROR: This script must be executed with root privileges."
  echo
fi

exit 0

