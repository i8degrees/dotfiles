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

set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace

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
   proxmox-backup-client logout
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
ARG_TYPE="$1" # root | home
EXCLUSIONS_LIST=""
REPOSITORY_URI=""

# IMPORTANT(JEFF): The following two variables can also be referred to from
# their respective file paths as commented below.
# /var/lib/proxmox-backup/pbs1.password
ROOT_INCLUDES="--include-dev /efi --include-dev /boot"
# ~/.config/proxmox-backup/pbs1.password
HOME_INCLUDES="--include-dev /home"

if [ "$ARG_HOST" != "" ]; then
  HOST="$ARG_HOST"
fi

if [ "$ARG_TYPE" = "" ]; then
  ARG_TYPE="home"
fi

if [[ "$ARG_TYPE" = "system" ]] && [[ ! "$USER" = "root" ]]; then
   echo "CRITICAL: This script must be ran as the superuser, root."
   echo
   exit 2
fi

if [[ "$ARG_TYPE" = "home" ]] && [[ "$USER" != "root" ]]; then
  PASSFILE="$HOME/.config/proxmox-backup/pbs1.password"
elif [[ "$ARG_TYPE" = "system" ]] && [[ "$USER" = "root" ]]; then
  # TODO(JEFF): This should become a variable that can be modified by
  # redefining "PASSFILE" outside of the script to the user's preferred
  # location, i.e.: PASSFILE=/new/location; backup-host.sh <ARGS>
  PASSFILE="/var/lib/proxmox-backup/pbs1.password"
fi

if [ -f "$PASSFILE" ]; then
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

if [[ -n "$EXCLUSIONS" ]] && [[ "$EXCLUSIONS" != "" ]]; then
  EXCLUSIONS_LIST="$EXCLUSIONS"
  echo "INFO: Using the exclusion list from ${PASSFILE}."
  echo
else
  echo "INFO: Not using the exclusion list from ${PASSFILE}."
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
  echo "CRITICAL: Failed to create ${XDG_RUNTIME_DIR}..."
  echo
  exit 2
fi

proxmox-backup-client login
cleanup_passwords

if [ -z "$NAMESPACE" ]; then # NAMESPACE variable is NOT declared

  if [ "$ARG_TYPE" = "system" ]; then
    # rootfs dirs
    if [ -e "/.pxarexclude" ]; then
      echo "INFO: Using exclusion list at /.pxarexclude"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_root.pxar:/" $ROOT_INCLUDES
    else
      echo "INFO: Using exclusion list from $PASSFILE"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_root.pxar:/" $EXCLUSIONS_LIST $ROOT_INCLUDES
    fi
  elif [ "$ARG_TYPE" = "home" ]; then
    # home dir (user)
    if [ -e "$HOME/.pxarexclude" ]; then
      echo "INFO: Using exclusion list at $HOME/.pxarexclude"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_home.pxar:/home" $HOME_INCLUDES
    else # .config/proxmox-backup/pbs1
      echo "INFO: Using exclusion list from $PASSFILE"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_home.pxar:/home" $EXCLUSIONS_LIST $HOME_INCLUDES
    fi # if [ -e "$HOME/.pxarexclude" ]; then
  fi # system

else # NAMESPACE variable is declared in configuration

  if [ "$ARG_TYPE" = "system" ]; then
    # rootfs dirs
    if [ -e "/.pxarexclude" ]; then
      echo "INFO: Using exclusion list at /.pxarexclude"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_root.pxar:/" $ROOT_INCLUDES --ns "$NAMESPACE"
    else
      echo "INFO: Using exclusion list from $PASSFILE"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_root.pxar:/" $EXCLUSIONS_LIST $ROOT_INCLUDES --ns "$NAMESPACE"
    fi
  elif [ "$ARG_TYPE" = "home" ]; then
    # home dir (user)
    if [ -e "$HOME/.pxarexclude" ]; then
      echo "INFO: Using exclusion list at $HOME/.pxarexclude"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_home.pxar:/home" $HOME_INCLUDES --ns "$NAMESPACE"
    else
      echo "INFO: Using exclusion list from $PASSFILE"
      # shellcheck disable=SC2086
      proxmox-backup-client backup "${HOST}_home.pxar:/home" $EXCLUSIONS_LIST $HOME_INCLUDES --ns "$NAMESPACE"
    fi
  fi

fi

cleanup
