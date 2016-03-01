#!/bin/bash
#
# 2016-02/22:jeff
#
# User function helpers for Darwin

# Derives from Fielding's dotfiles repo
# https://github.com/justfielding/dotfiles
function timecap()
{
  parent="$(which pwd)"
  filenumber=${1:-1}
  delay=${2:-5}
  scdir=${3:-${parent}}
  date_bin=$(which date)
  screencap_bin="$(which screencapture)"
  i=$filenumber

  while "true"
    do $screencap_bin -t jpg -x "${scdir}""${i}"_"${timestamp}".jpg
    timestamp="$($date_bin +%y-%m-%d_%s)"
    echo "Capturing to ${i}_${timestamp}.jpg"
    let i++
    sleep "$delay"
  done
}

function tagwhere()
{
  if [[ -z "$1" ]]; then
    echo "Usage: tagwhere <url> <file_path>"
  else
    xattr -p 'com.apple.metadata:kMDItemWhereFroms' "$1"
  fi
}

# SOURCE: http://www.devopsderek.com/blog/2013/03/10/view-man-pages-with-preview-on-mac-os-x/
PREVIEW_APP_BIN="/Applications/Preview.app/Contents/MacOS/Preview"
if [[ -x "${PREVIEW_APP_BIN}" ]]; then
  function gman()
  {
    local PATH=/usr/bin
    man -t "${@}" | open -f -a "$(basename ${PREVIEW_APP_BIN})"
  }
fi

# Package management helper commands for Homebrew
if [[ -x "$(which brew)" ]]; then

  if [[ "${NOM_DEBUG}" -gt 0 ]]; then
    echo "LOCAL_SITE_PREFIX: ${LOCAL_SITE_PREFIX}"
  fi

  function brewupgrade()
  {
    local PATH="${LOCAL_SITE_PREFIX}"
    local TERM=xterm-256color

    brew doctor; brew missing; brew update; brew upgrade --all; brew cleanup
  }

  function brew_cask_upgrade()
  {
    local PATH="${LOCAL_SITE_PREFIX}"
    local TERM=xterm-256color

    brew cask update; brew cask cleanup
  }
fi # end if brew

function fullpath()
{
  PARENT_WORKING_DIR=$(pwd)
  FILE_ARG=${1}
  echo "${PARENT_WORKING_DIR}/${FILE_ARG}"
}

function fullpathcopy()
{
  PBCOPY_BIN=$(which pbcopy)
  fullpath 1 | ${PBCOPY_BIN}
}
