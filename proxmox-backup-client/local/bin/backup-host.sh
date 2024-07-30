#!/usr/bin/env bash
#
# Custom backup script using proxmox-backup-client
#
# WARNING(JEFF): This script should generally be expected to be
# non-interactive; when a password file is found, it is tried and
# if the given password is correct, this script remains non-interactive.
# Otherwise, this script becomes interactive as it must ask the user
# for a password to login before it can initiate the backup.
#
# 2. TODO(JEFF): Rename systemd unit files; from
# `proxmox-backup-client@.(service|timer)` to `proxmox-backup@.(service|timer)`.
# Update installation documentation at the said unit files.
#
# 3. TODO(JEFF): Rename pbs1.password to pbs1.passwd
#
# 4. TODO(JEFF): Integrate the usage of this script into our Docker Compose
# script for performing client-side restores from within this container
# run-time -- a recovery image, if you will.
#
# 5. TODO(JEFF): Integrate support for handling pre and post backup hooks;
# so called "hooks" shall be shell scripts that are specified by the end-user
# and then called by this script at the appropiate phases.
#

if [ -n "$DEBUG" ]; then
  set -o errexit
  #set -o nounset
  #set -o pipefail
  #set -o xtrace
fi

# IMPORTANT(JEFF): Ensure that we have a sane homedir environment!
if [ -z "$HOME" ]; then
  if [ "$(id -u)" = "0" ]; then
    HOME="/root"
  else
    HOME="/home/$(id -un)"
  fi
fi

[ -n "$DEBUG" ] && echo "HOME: $HOME"

LIB_PATH=""
if [ -x "/opt/sbin/pve_util.sh" ]; then # make install
  LIB_PATH="/opt/sbin/pve_util.sh"
elif [ -x "$HOME/local/lib/pve_util.sh" ]; then # stow proxmox-backup-client
  LIB_PATH="$HOME/local/lib/pve_util.sh"
fi

if [ ! -e "$LIB_PATH" ]; then
  echo "CRITICAL: Failed to find pve_util.sh."
  echo
  echo "LIB_PATH=${LIB_PATH}"
  echo "HOME=${HOME}"
  echo
  exit 2
fi

[ -n "$DEBUG" ] && echo "LIB_PATH: $LIB_PATH"

# shellcheck disable=SC1090
source "$LIB_PATH"

# Specific cleanup code for sanitizing the passwords from memory; this
# function is safe to be called explicitly.
#
# void cleanup_passwords()
cleanup_passwords() {
   PBS_PASSWORD=""; unset PBS_PASSWORD
   PASSPHRASE=""; unset PASSPHRASE
}

# Trap function; this function is also safe to call directly.
#
# void cleanup()
cleanup() {
   run_cmd proxmox-backup-client logout
   cleanup_passwords
   REPOSITORY=""; unset REPOSITORY
   EXCLUSIONS=""; unset EXCLUSIONS
}

# IMPORTANT(JEFF): Always try to ensure that we leave our environment
# sanitized of any sensitive data.
trap 'cleanup' SIGINT
trap 'cleanup' ERR

# Print usage information, and optionally, when an exit code is provided,
# exit the script with the specified exit code.
#
# exit_code - unsigned integer
#
# usage_info(exit_code)
usage_info() {
  script_name="$(basename "${0}")"
  exit_code="$1"

  echo -e "Usage:\n"
  echo -e "\t${script_name} [OPTIONS] <system|home> <HOSTNAME>\n"
  echo -e "Options:\n"
  echo -e "\t-h,  --help\tDisplay this help text and exit\n"
  echo -e "\t-X,  --exclusion-file\tProvide an exclusion list file\n"
  echo -e "\t-f,  --file\tLoad host-specific environment\n"
  echo

  if [ "$exit_code" != "" ]; then
    exit "$exit_code"
  fi
}

HOST=$(hostname --short)
ARG_HOST="$2"
BACKUP_NAME="$1" # root | home
EXCLUSIONS_LIST=""
REPOSITORY_URI=""
INCLUDES=""

if [ "$ARG_HOST" != "" ]; then
  HOST="$ARG_HOST"
fi

if [ "$BACKUP_NAME" = "" ]; then
  BACKUP_NAME="home"
fi

if [[ "$BACKUP_NAME" = "system" ]] && [[ ! "$(id -u)" = "0" ]]; then
   echo "CRITICAL: This script must be ran as the superuser, root."
   echo
   #exit 2
fi

# FIXME(JEFF): Verify that the file permissions of this file are sane!
# chmod 0600 or so is appropiate -- it must be readable by ONLY the
# user that this script is initiated from.
#if [ "stat -c %a $PASSFILE" != "600" ]; then
  #echo "ERROR: Your password file must have its permissions set to 600."
  #echo
  #echo "Please run 'chmod -v 600" ${PASSFILE}"' to fix this error condition."
  #echo
  #exit 4
#fi

PASSFILE="${HOME}/.config/proxmox-backup/pbs1.password"
if [ -f "$PASSFILE" ]; then
  echo "INFO: Loading environment from the file at ${PASSFILE}..."
  echo
  # shellcheck disable=SC1090
  source "$PASSFILE"
elif [ ! -f "$PASSFILE" ]; then
   echo "WARNING: Failed to find password file at ${PASSFILE}..."
   echo
   echo "INFO: You will be prompted for the login password. You may also "
   echo "need to set PBS_REPOSITORY before running this script again."
   echo
fi

if [[ -n "$PBS_REPOSITORY" ]] && [[ "$PBS_REPOSITORY" != "" ]]; then
  # Handle the case where the user sets the repository from an env var
  REPOSITORY_URI="$PBS_REPOSITORY"
else
  # Handle the case where the user has set the repository URI from the
  # passfile
  REPOSITORY_URI="$REPOSITORY"
fi

if [ "$REPOSITORY_URI" = "" ]; then
  echo "ERROR: The PBS_REPOSITORY environment variable must be a string of "
  echo "non-zero length. Please refer to the user documentation of "
  echo "proxmox-backup-client for details on how to correctly construct "
  echo "this string."
  echo
  exit 2
fi

# proxmox-backup-client demands this of us to be set ahead of executing the
# backup client
PBS_PASSWORD="$PASSPHRASE"; export PBS_PASSWORD
PBS_REPOSITORY="$REPOSITORY_URI"; export PBS_REPOSITORY

echo "INFO: Using repository at ${REPOSITORY_URI} for $HOST..."

# IMPORTANT(JEFF): proxmox-backup-client will not start without
# XDG_RUNTIME_DIR being declared and setup proper.
RUNTIME_DIR="/run/user/$(id -u)"
XDG_RUNTIME_DIR="$RUNTIME_DIR"; export XDG_RUNTIME_DIR

mkdir -p "$XDG_RUNTIME_DIR" && chmod 0700 "$XDG_RUNTIME_DIR"

if [ ! -d "$XDG_RUNTIME_DIR" ]; then
  echo "CRITICAL: Failed to create ${XDG_RUNTIME_DIR} from XDG_RUNTIME_DIR..."
  echo
  exit 2
fi

# example pre-hook
# shellcheck disable=SC2034
PRE_HOOK_EXEC="$HOME/local/etc/proxmox-backup/hooks/pre_hook.sh"
#[ -x "$PRE_HOOK_EXEC" ] && run_cmd "$PRE_HOOK_EXEC"

run_cmd proxmox-backup-client login
cleanup_passwords

if [ "$BACKUP_NAME" = "system" ]; then
  if [[ -n "$ROOT_INCLUDES" ]] && [[ "$ROOT_INCLUDES" != "" ]]; then
    INCLUDES=$(parse_inclusions $ROOT_INCLUDES)
  fi
elif [ "$BACKUP_NAME" = "home" ]; then
  if [[ -n "$HOME_INCLUDES" ]] && [[ "$HOME_INCLUDES" != "" ]]; then
    INCLUDES=$(parse_inclusions $HOME_INCLUDES)
  fi
fi

[ -n "$DEBUG" ] && echo $INCLUDES

if [[ -n "$EXCLUSIONS" ]] && [[ "$EXCLUSIONS" != "" ]]; then
  EXCLUSIONS_LIST=$(parse_exclusions $EXCLUSIONS)
fi

[ -n "$DEBUG" ] && echo $EXCLUSIONS_LIST

EXTRA_ARGS=()
if [ "$BACKUP_NAME" = "home" ]; then
  # shellcheck disable=SC2206
  EXTRA_ARGS+=("${HOST}_home.pxar:/home" $EXCLUSIONS_LIST $INCLUDES)
else
  # shellcheck disable=SC2206
  EXTRA_ARGS+=("${HOST}_root.pxar:/" $EXCLUSIONS_LIST $INCLUDES)
fi

if [ -n "$NAMESPACE" ]; then
  EXTRA_ARGS+=("--ns" "$NAMESPACE")
fi

echo "proxmox-backup-client backup ${EXTRA_ARGS[@]}"
run_cmd proxmox-backup-client backup "${EXTRA_ARGS[@]}"

# example post-hook
# shellcheck disable=SC2034
POST_HOOK_EXEC="$HOME/local/etc/proxmox-backup/hooks/post_hook.sh"
#[ -x "$POST_HOOK_EXEC" ] && run_cmd "$POST_HOOK_EXEC"

cleanup
