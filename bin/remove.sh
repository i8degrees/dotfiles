#!/bin/bash

# TODO(jeff): Add --ignore=.DS_Store* onto all of the stow commands!

# IMPORTANT(jeff): Setup system PATH and user environment, i.e.:
# $XDG_CONFIG_HOME
# BASH_PROFILE="bash/bash_profile"
# shellcheck source=bash/bash_profile
# source "${BASH_PROFILE}"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_MUSIC_DIR="/Volumes/Media/Music"
PATH="/usr/bin:/usr/local/bin:/bin"
WORKING_DIR=$(pwd)

STOW_IGNORE_LIST=".DS_Store*"

# FIXME(jeff): We should not be removing top-level directories at all, in case
# we accidentally start editing a file in one of these directories and then
# later run this command -- unexpectedly losing work!

# FIXME(jeff): We musn't rely on non-standard variants of user-space
# filesystem utility binaries, i.e.: GNU rm from the coreutils package.
#
#   In summary, none of the options listed under the COMPATIBILITY section of
# the applicable man pages should be used when stated as non-standard.
#
#   See also,
#     rm(1), rmdir(1)
RM_COMMAND=$(which rm)

# wget configuration
stow -v -D wget

# curl configuration
stow -v -D curl

# ruby gems configuration
stow -v -D ruby

# git configuration
stow --ignore="${STOW_IGNORE_LIST}" -v -D git

# htop configuration
stow --ignore="${STOW_IGNORE_LIST}" -v -D htop

# vim configuration
stow -v --ignore="${STOW_IGNORE_LIST}" -D vim

# mplayer configuration
${RM_COMMAND} -rv ${HOME}/.mplayer

# mpv configuration
declare MPV_IGNORE_LIST=STOW_IGNORE_LIST
MPV_IGNORE_LIST+="watch_later/*"
stow --ignore="${MPV_IGNORE_LIST}" -v -D mpv

# hg configuration
stow -v -d "${WORKING_DIR}" -t "${HOME}" -D hg

# tmux configuration
stow -v -d "${WORKING_DIR}" -t "${HOME}" -D tmux

# gtk configuration
stow -v -D gtk

# pianobar cfg
stow -v -D pianobar

# emacs cfg
# ${RM_COMMAND} -rv ${HOME}/.emacs
stow -v --ignore="${STOW_IGNORE_LIST}" -D emacs

# grc cfg
stow -v --ignore="${STOW_IGNORE_LIST}" -D grc

case "$(uname -s)" in
Darwin)

  if [[ -n "${FIREFOX_CONFIG}" ]]; then
    # TODO
  fi

  stow -v --ignore="${STOW_IGNORE_LIST}" -D wakeonlan

  # iTerm configuration
  stow --ignore="${STOW_IGNORE_LIST}" -v iterm2.9

  # Mac OS X Automator Services
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/Duplicate Tab.workflow"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/New File.workflow"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/Zoom In.workflow"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/Zoom Out.workflow"

  # ncmcpp configuration
  stow --ignore="${STOW_IGNORE_LIST}" -v -D ncmpcpp

  # mpd daemon configuration
  if [[ "$(which mpd)" ]]; then
    launchctl stop "${HOME}/Library/LaunchAgents/org.local.mpd.plist"
    launchctl unload "${HOME}/Library/LaunchAgents/org.local.mpd.plist"

    # mpdscribble configuration
    if [[ "$(which mpdscribble)" ]]; then
      launchctl stop "${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist"
      launchctl unload "${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist"
    fi

    rm -rv "${XDG_CONFIG_HOME}/mpd/music"
    rm -rv "${XDG_CONFIG_HOME}/mpd/playlists"
  fi

  # mpd configuration
  stow --ignore="${STOW_IGNORE_LIST}" -v -D mpd
  stow --ignore="${STOW_IGNORE_LIST}" -v -D mpd-osx

  # mpdscribble configuration
  stow --ignore="${STOW_IGNORE_LIST}" -v -D mpdscribble
  stow --ignore="${STOW_IGNORE_LIST}" -v -D mpdscribble-osx

  # synergys configuration
  # stow --ignore="${STOW_IGNORE_LIST}" -v -D synergy
  # stow --ignore="${STOW_IGNORE_LIST}" -v -D synergy-osx

  # unison configuration
  launchctl unload ~/Library/LaunchAgents/org.local.unison_nomlib.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_nomdev.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_ttcards.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_third-party.plist

  stow -v --ignore="${STOW_IGNORE_LIST}" -D unison
  stow -v --ignore="${STOW_IGNORE_LIST}" -D unison-osx

  # pow configuration
  stow -v --ignore="${STOW_IGNORE_LIST}" -D pow

  # Hermes app helper script
  stow -v --ignore="${STOW_IGNORE_LIST}" -D hermes

  # Marked 2
  stow -v --ignore="${STOW_IGNORE_LIST}" -D marked

  # Sublime Text
  stow -v --ignore="${STOW_IGNORE_LIST}" -D sublime-text

  # OpenAL-soft configuration
  stow -v --ignore="${STOW_IGNORE_LIST}" -D openal

  # ssh && sshd
  stow -v --ignore="${STOW_IGNORE_LIST}" ssh

  # API token keys
  rm -rv "${HOME}/.api_tokens"

  stow -v --ignore="${STOW_IGNORE_LIST}" -D osx

  ;;
Linux)
  # stow -v --ignore="${STOW_IGNORE_LIST}" -D samba

  stow -v --ignore="${STOW_IGNORE_LIST}" -D X11
  ;;
*)
  # Catch-all
  ;;
esac

# Bash configuration
stow --ignore="${STOW_IGNORE_LIST}" -v -D bash

# readline configuration
stow -v -D readline
