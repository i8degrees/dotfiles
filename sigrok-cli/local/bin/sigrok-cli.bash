#!/usr/bin/env bash
#
# Simple cli alias wrapper for AppImage bundles
#

APP_PREFIX="$HOME/Applications"
APP_PATH="sigrok-cli-NIGHTLY-x86_64-debug.AppImage"

if [[ ! -x "${APP_PREFIX}/${APP_PATH}" ]]; then
  echo "CRITICAL: The binary at ${APP_PREFIX}/${APP_PATH} must be marked executable..."
  echo
  exit 252
fi

if [ -e "${APP_PREFIX}/${APP_PATH}" ]; then
  /bin/sh -c "${APP_PREFIX}/${APP_PATH}" &
else
  echo "CRITICAL: Missing binary at ${APP_PREFIX}/${APP_PATH}..."
  echo
  exit 254
fi

