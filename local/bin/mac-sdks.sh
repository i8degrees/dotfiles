#!/bin/sh
# Jeffrey Carpenter <i8degrees@gmail.com>

function usage_info()
{
  SCRIPT_NAME=$(basename $0)

  echo "Usage: ${SCRIPT_NAME} <command>\n"
  echo "...where <command> is INSTALL or REMOVE"
  echo
  echo "./${SCRIPT_NAME} install"
  echo "./${SCRIPT_NAME} remove"
  echo
  echo "  DESCRIPTION"
  echo
  echo "Install or remove additional Mac OS X, iOS and iOS Simulator"
  echo "development files for the App Store version of Xcode."
  echo
  echo "  ENVIRONMENT VARIABLES"
  echo
  echo "For a dry run, set NOM_DRY_RUN"
  echo "    NOM_DRY_RUN=true ./${SCRIPT_NAME} <command>"
  echo
  echo "To enable verbose logging, set NOM_SDK_DEBUG"
  echo "    NOM_SDK_DEBUG=true ./${SCRIPT_NAME} <command>"
  echo
  echo "To change the SDK source path used for installation, set NOM_DEV_ROOT"
  echo "    NOM_DEV_ROOT=/Developer/SDKs ./${SCRIPT_NAME} <command>"
  exit 0
}

function exec_cmd()
{
  local RET=-1

  if [[ !($1) ]]; then
    return $RET
  fi

  # Fire in the hole!
  $1
  RET=$?

  # If the exit code if the command is not zero, assume that something bad has
  # happened and terminate this script with the same exit code.
  if [[ $RET != 0 ]]; then
    if [[ $NOM_SDK_DEBUG ]]; then
      echo "ERROR (fatal): Failure to execute input...\n"
    fi
    exit $RET
  fi

  return $RET
}

function install_sdks()
{
  PATH_INDEX=0
  INSTALL_COUNT=0
  for src_path in ${SDK_SOURCE_LIST[*]}
  do
    dest_path=${SDK_DEST_LIST[$PATH_INDEX]}

    if [[ $NOM_SDK_DEBUG ]]; then
      echo "SRC_PATH: ${src_path}"
      echo "DEST_PATH: ${dest_path}"
      echo "PATH_INDEX: ${PATH_INDEX}"
    fi

    if [[ -L ${dest_path} ]]; then
      echo "WARN: file exists at ${dest_path} -- skipping"
    else
      if [[ $NOM_DRY_RUN ]]; then
        echo "${LN_BIN} -s ${src_path} ${dest_path}"
      else
        echo "INFO: installing development files at ${dest_path}"
        exec_cmd "${LN_BIN} -s ${src_path} ${dest_path}"
        INSTALL_COUNT=$[$INSTALL_COUNT + 1]
      fi
    fi

    PATH_INDEX=$[$PATH_INDEX + 1]
  done
}

function remove_sdks()
{
  REMOVE_COUNT=0
  for path in ${SDK_DEST_LIST[*]}
  do
    if [[ $NOM_SDK_DEBUG ]]; then
      echo "PATH: ${path}"
    fi

    if [[ !(-L ${path}) ]]; then
      echo "WARN: file does not exist at ${path} -- skipping"
    else
      if [[ $NOM_DRY_RUN ]]; then
        echo "${RM_BIN} ${path}"
      else
        echo "INFO: Removing development files at ${path}"
        exec_cmd "${RM_BIN} ${path}"
        REMOVE_COUNT=$[$REMOVE_COUNT + 1]
      fi
    fi
  done
}

# Prefix source path for the SDKs
if [[ $NOM_DEV_ROOT ]]; then
  if [[ !(-x ${NOM_DEV_ROOT}) ]]; then
    echo "ERROR (fatal): The given source SDK path does not exist at ${NOM_DEV_ROOT}"
    exit -1
  else
    # Custom path, set by end-user on command-line
    DEV_SDK_ROOT=${NOM_DEV_ROOT}
  fi
else
  # Default path
  DEV_SDK_ROOT="/Developer/SDKs"
fi

# Absolute path to ln binary
LN_BIN="/bin/ln"

# Absolute path to rm binary
RM_BIN="/bin/rm"

# Mac OS X SDK destination path
OSX_SDK_ROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs"

# iOS SDK destination path
IOS_SDK_ROOT="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs"

# iOS Simulator SDK destination path
IOS_SIM_SDK_ROOT="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs"

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

# ...Verify that the source paths are valid

if [[ ! -d ${DEV_SDK_ROOT} ]]; then
  echo "ERROR: DEV_SDK_ROOT: ${DEV_SDK_ROOT}"
  exit -1
fi

if [[ ! -d ${OSX_SDK_ROOT} ]]; then
  echo "ERROR: Mac OS X: ${OSX_SDK_ROOT}"
  exit -1
fi

if [[ ! -d ${IOS_SDK_ROOT} ]]; then
  echo "ERROR: iOS: ${IOS_SDK_ROOT}"
  exit -1
fi

if [[ ! -d ${IOS_SIM_SDK_ROOT} ]]; then
  echo "ERROR: iOS Simulator: ${IOS_SIM_SDK_ROOT}"
  exit -1
fi

# NOTE(jeff): Set by end-user on command-line
if [[ $NOM_SDK_DEBUG ]]; then
  echo "DEV_SDK_ROOT: ${DEV_SDK_ROOT}"
  echo "OSX_SDK_ROOT: ${OSX_SDK_ROOT}"
  echo "IOS_SDK_ROOT: ${IOS_SDK_ROOT}"
  echo "IOS_SIM_SDK_ROOT: ${IOS_SIM_SDK_ROOT}"
fi

# NOTE(jeff): Set by end-user on command-line
if [[ $NOM_DRY_RUN ]]; then
  echo "This script is a dry run; execution logic is shown, not ran.\n"
fi

if [[ $1 == "install" || $1 == "INSTALL" ]]; then
  install_sdks
elif [[ $1 == "remove" || $1 == "REMOVE" ]]; then
  remove_sdks
else
  usage_info
fi

exit 0
