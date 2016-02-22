#!/bin/bash
# 2016-02/19:jeff

function usage_info()
{
  SCRIPT_NAME=$(basename "${0}")

  echo -e "Usage: ${SCRIPT_NAME} <command>\n"
  echo -e "...where <command> is INSTALL or REMOVE"
  echo -e
  echo -e "./${SCRIPT_NAME} install"
  echo -e "./${SCRIPT_NAME} remove"
  echo -e
  echo -e "  DESCRIPTION"
  echo -e
  echo -e "Install or remove additional Mac OS X, iOS and iOS Simulator"
  echo -e "development files for the App Store version of Xcode."
  echo -e
  echo -e "  ENVIRONMENT VARIABLES"
  echo -e
  echo -e "For a dry run, set NOM_DRY_RUN"
  echo -e "    NOM_DRY_RUN=true ./${SCRIPT_NAME} <command>"
  echo -e
  echo -e "To enable verbose logging, set NOM_SDK_DEBUG"
  echo -e "    NOM_SDK_DEBUG=true ./${SCRIPT_NAME} <command>"
  echo -e
  echo -e "To change the SDK source path used for installation, set NOM_DEV_ROOT"
  echo -e "    NOM_DEV_ROOT=/Developer/SDKs ./${SCRIPT_NAME} <command>"
}

function exec_cmd()
{
  local RET_CODE=-1
  EXEC_CMD=$*

  if [[ -z "${EXEC_CMD}" ]]; then
    return "${RET_CODE}"
  fi

  # Fire in the hole!
  if [[ -n "${NOM_DRY_RUN}" ]]; then
    echo "DRY RUN: ${EXEC_CMD}"
    RET_CODE=0
  else
    ${EXEC_CMD}
    RET_CODE=$?
  fi

  if [[ "${RET_CODE}" != 0 ]]; then
    echo -e "ERROR: Failure to execute input: \n\t${EXEC_CMD}\n"
    # EX_UNAVAILABLE (69) as per man 3 sysexits (BSD)
    # exit 69
    exit "${RET_CODE}"
  fi

  return "${RET_CODE}"
}

function install_sdks()
{
  local INSTALL_COUNT=0

  echo "INFO: installing development SDK files..."

  local PATH_INDEX=0
  for src_path in ${SDK_SOURCE_LIST[*]}; do
    dest_path=${SDK_DEST_LIST[$PATH_INDEX]}

    if [[ -n "${NOM_SDK_DEBUG}" ]]; then
      echo "PATH_INDEX: ${PATH_INDEX}"
    fi

    if [[ -L "${dest_path}" ]]; then
      echo "WARN: file exists at ${dest_path} -- skipping"
    else
      if [[ ! (-x ${src_path}) ]]; then
        echo "WARN: source file does not exist at ${src_path} -- skipping"
      else
        exec_cmd "sudo ln -sfv ${src_path} ${dest_path}"
        let INSTALL_COUNT=$INSTALL_COUNT+1
      fi
    fi

    let PATH_INDEX=$PATH_INDEX+1
  done

  echo "INFO: Installed ${INSTALL_COUNT} SDKs."
}

function remove_sdks()
{
  echo "INFO: Removing development SDK files..."

  local REMOVE_COUNT=0
  for path in ${SDK_DEST_LIST[*]}; do

    if [[ ! (-L "${path}") ]]; then
      echo "WARN: file does not exist at ${path} -- skipping"
    else
      exec_cmd "rm -rfv ${path}"
      let REMOVE_COUNT=$REMOVE_COUNT+1
    fi
  done

  echo "INFO: Removed ${REMOVE_COUNT} SDKs."
}

function validate_paths()
{
  if [[ ! (-r "${DEV_SDK_ROOT}") ]]; then
    echo "ERROR (fatal): no such file or directory at ${DEV_SDK_ROOT}"
    exit 2 # ENOENT; man 2 intro
  fi

  if [[ ! (-r "${OSX_SDK_ROOT}") ]]; then
    echo "ERROR (fatal): no such file or directory at ${OSX_SDK_ROOT}"
    exit 2 # ENOENT; man 2 intro
  fi

  if [[ ! (-r "${IOS_SDK_ROOT}") ]]; then
    echo "ERROR (fatal): no such file or directory at ${IOS_SDK_ROOT}"
    exit 2 # ENOENT; man 2 intro
  fi

  if [[ ! (-r "${IOS_SIM_SDK_ROOT}") ]]; then
    echo "ERROR (fatal): no such file or directory at ${IOS_SIM_SDK_ROOT}"
    exit 2 # ENOENT; man 2 intro
  fi
}

# NOM_DEV_ROOT is an optional, end-user set path
if [[ -n "${NOM_DEV_ROOT}" && -r "${NOM_DEV_ROOT}" ]]; then
  DEV_SDK_ROOT=${NOM_DEV_ROOT}
else
  # Err; user given path doesn't exist!
  DEV_SDK_ROOT="/Developer/SDKs"
fi

echo "INFO: Using default development SDK path at ${DEV_SDK_ROOT}"

PATH=/bin:/usr/bin # ln, rm, xcode-select

PREFIX_SDK_PATH=$(xcode-select -p)

if [[ $? != 0 ]]; then
  PREFIX_SDK_PATH="/Applications/Xcode.app/Contents/Developer"

  if [[ ! (-r "${PREFIX_SDK_PATH}") ]]; then
    echo "ERROR (fatal): no such file or directory at ${PREFIX_SDK_PATH}"
    echo
    echo -e "\tPlease install Xcode's Command Line Tools"
    echo "xcode-select cannot be found at any of the directories at ${PATH}"
    exit 2 # ENOENT; man 2 intro
  fi
fi

# Mac OS X SDK destination path
OSX_SDK_ROOT="${PREFIX_SDK_PATH}/Platforms/MacOSX.platform/Developer/SDKs"

# iOS SDK destination path
IOS_SDK_ROOT="${PREFIX_SDK_PATH}/Platforms/iPhoneOS.platform/Developer/SDKs"

# iOS Simulator SDK destination path
IOS_SIM_SDK_ROOT="${PREFIX_SDK_PATH}/Platforms/iPhoneSimulator.platform/Developer/SDKs"

# Absolute paths to the development SDK file source
SDK_SOURCE_LIST=(
  #
  "${DEV_SDK_ROOT}/MacOSX10.4.sdk"
  "${DEV_SDK_ROOT}/MacOSX10.6.sdk"
  "${DEV_SDK_ROOT}/MacOSX10.7.sdk"
  "${DEV_SDK_ROOT}/MacOSX10.8.sdk"
  "${DEV_SDK_ROOT}/MacOSX10.9.sdk"
  "${DEV_SDK_ROOT}/MacOSX10.10.sdk"
  #
  "${DEV_SDK_ROOT}/iPhoneOS7.1.sdk"
  "${DEV_SDK_ROOT}/iPhoneOS8.1.sdk"
  #
  "${DEV_SDK_ROOT}/iPhoneSimulator7.1.sdk"
  "${DEV_SDK_ROOT}/iPhoneSimulator8.1.sdk"
)

# The installation paths of the development SDK files
SDK_DEST_LIST=(
  #
  "${OSX_SDK_ROOT}/MacOSX10.4.sdk"
  "${OSX_SDK_ROOT}/MacOSX10.6.sdk"
  "${OSX_SDK_ROOT}/MacOSX10.7.sdk"
  "${OSX_SDK_ROOT}/MacOSX10.8.sdk"
  "${OSX_SDK_ROOT}/MacOSX10.9.sdk"
  "${OSX_SDK_ROOT}/MacOSX10.10.sdk"
  #
  "${IOS_SDK_ROOT}/iPhoneOS7.1.sdk"
  "${IOS_SDK_ROOT}/iPhoneOS8.1.sdk"
  #
  "${IOS_SIM_SDK_ROOT}/iPhoneSimulator7.1.sdk"
  "${IOS_SIM_SDK_ROOT}/iPhoneSimulator8.1.sdk"
)

# ...Verify that the source paths are valid...
validate_paths

# NOTE(jeff): Set by end-user on command-line
if [[ -n "${NOM_SDK_DEBUG}" ]]; then
  echo "DEV_SDK_ROOT: ${DEV_SDK_ROOT}"
  echo "OSX_SDK_ROOT: ${OSX_SDK_ROOT}"
  echo "IOS_SDK_ROOT: ${IOS_SDK_ROOT}"
  echo "IOS_SIM_SDK_ROOT: ${IOS_SIM_SDK_ROOT}"
fi

# NOTE(jeff): Set by end-user on command-line
if [[ -n "${NOM_DRY_RUN}" ]]; then
  echo -e "This script is a dry run; execution logic is shown, not ran.\n"
fi

if [[ "${1}" == "install" || "${1}" == "INSTALL" ]]; then
  install_sdks
elif [[ "${1}" == "remove" || "${1}" == "REMOVE" ]]; then
  remove_sdks
else
  usage_info
  exit 0
fi

exit 0
