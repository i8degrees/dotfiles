#!/bin/bash
#
# 2016-02/21:jeff
#
# Local Bash (1) profile executed for login shells

#if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then

#if [[ -n $(tty) ]]; then
# command tmux
#fi

# NOM_DEBUG=2; export NOM_DEBUG

# TODO(jeff): Ensure this only gets done once!
# shellcheck source=./lib/util
source "${HOME}/.bash/lib/util"
NOM_PLATFORM=$(get_platform); export NOM_PLATFORM
NOM_HOST=$(get_host); export NOM_HOST

# NOTE(jeff): This is the installation prefix for system-wide user-land apps
# and configuration
LOCAL_SITE_PREFIX="/usr/local"; # export LOCAL_SITE_PREFIX

# NOTE(jeff): This is the installation prefix for user-specific user-land apps
# and configuration
# LOCAL_SITE_USER_PREFIX="${HOME}/local"

PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
export XDG_DATA_HOME="${HOME}/.local/share"
# export XDG_DATA_DIRS=""
export XDG_CONFIG_HOME="${HOME}/.config"
# export XDG_CONFIG_DIRS=""
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DESKTOP_DIR="${HOME}/Desktop"
export XDG_DOCUMENTS_DIR="${HOME}/Documents"
export XDG_DOWNLOADS_DIR="${HOME}/Downloads"
export XDG_MUSIC_DIR="/Volumes/Media/Music"
export XDG_PICTURES_DIR="/Volumes/Media/Pictures"
export XDG_PUBLICSHARE_DIR="${HOME}/Public"
# export XDG_TEMPLATES_DIR="${HOME}/Templates"
export XDG_VIDEOS_DIR="/Volumes/Media/Video"

# NOTE(jeff): Setup our local Ruby environment
NOM_USE_RBENV=true
RUBY_RC="${HOME}/.bash/ruby_config"
if [[ -f "${RUBY_RC}" ]]; then
  # shellcheck source=./ruby_config
  source "${RUBY_RC}"
fi

# Show GTest diagnostics output
CTEST_OUTPUT_ON_FAILURE=true; export CTEST_OUTPUT_ON_FAILURE

# Colored logging output from nomlib
NOM_COLOR=always; export NOM_COLOR

GTEST_COLOR=yes; export GTEST_COLOR

umask 0022  # u=rwx, g=rx, o=rx

PLATFORM_CONFIG="${HOME}/.bash/profile.d/${NOM_PLATFORM}.sh"
if [[ -r "${PLATFORM_CONFIG}" ]]; then
  # shellcheck disable=SC1090
  source "${PLATFORM_CONFIG}"
fi

export PATH

# NOTE(jeff): Setting this variable signals the dotfiles installer that we want
# to use our existing addons configuration files -- symbolic links will be added
# to this directory containing said settings.
# TODO(jeff): Implement this?
# FIREFOX_CONFIG=${HOME}/.config/firefox

BASHRC_CONFIG="${HOME}/.bashrc"
if [ -f "${BASHRC_CONFIG}" ]; then
  # shellcheck source=./bashrc
  source "${BASHRC_CONFIG}"
fi
