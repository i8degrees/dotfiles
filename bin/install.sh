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

# FIXME(jeff): We musn't rely on non-standard variants of user-space
# filesystem utility binaries, i.e.: GNU ln from the coreutils package.
#
# Synopsis: The ln binary from GNU's coreutils distribution supports a very
# convenient -- but **non-standard** -- switch by the name of
# --no-target-directory (-T).
#   This -T switch spares us from always checking to see if the target file is
# an existing soft-link, as if one relinks such a target, a nested soft link
# follows -- almost never the desired result we are looking for here.
#
#   In summary, none of the options listed under the COMPATIBILITY section of
# the applicable man pages should be used when stated as non-standard.
#
#   See also,
#     ln(1), link(2)
LINK_COMMAND=$(which ln)

# git clone https://github.com/i8degrees/dotfiles.git
# cd ${WORKING_DIR}

# TODO(jeff): Setup .bash_env file with BASH_HOSTNAME set to your system's
# permanent host name

# wget configuration
stow -v wget

# curl configuration
stow -v curl

# ruby gems configuration
stow -v ruby

# ctags
stow -v ctags

# git configuration
stow --ignore="${STOW_IGNORE_LIST}" -v git

# htop configuration
stow --ignore="${STOW_IGNORE_LIST}" -v htop

# vim configuration
stow -v --ignore="${STOW_IGNORE_LIST}" vim

# readline configuration
stow --ignore="${STOW_IGNORE_LIST}" -v readline

# Bash configuration
stow --ignore="${STOW_IGNORE_LIST}" -v bash

# mplayer configuration
#${LINK_COMMAND} -sf ${WORKING_DIR}/mplayer/ $HOME/.mplayer

# mpv player configuration
declare MPV_IGNORE_LIST=STOW_IGNORE_LIST
MPV_IGNORE_LIST+="watch_later/*"
stow --ignore="${MPV_IGNORE_LIST}" -v mpv

# Firefox config
# TODO(jeff): Implement this? I have commented out the FIREFOX_CONFIG variable,
# so none of this should execute in the mean time.
if [[ -d "${FIREFOX_CONFIG}" ]]; then

  # Prepare the destination path by creating it if it does not yet exist
  mkdir -p ${FIREFOX_CONFIG}

  # Sync the addons configuration files
  #
  # TODO(jeff): This step needs to be done on a frequent basis -- a cron job
  # set to run daily or even hourly would be ideal. We would just symlink from
  # the source directly if only I knew how reliable it was! Better safe than
  # sorry, aye?
  function sync_addons_configuration()
  {
    local CONFIG_ROOT="/Users/jeff/Library/Application Support/Firefox/Profiles"
    local PROFILE_ID="c3jj6i1k.default"
    local EXT_ID="jid1-MnnxcxisBPnSXQ@jetpack"
    local PRIVACY_BADGER_CONFIG="${CONFIG_ROOT}/${PROFILE_ID}/jetpack/${EXT_ID}/simple-storage/store.json"

    local PATH="/bin"
    # TODO(jeff): We cannot rely on a persistent profile path for Firefox    The Firefox configuration prefix path is always going to be
    # dependent
    # a) profile name; b)
    local PRIVACY_BADGER_CONFIG="${CONFIG_ROOT}/${PROFILE_ID}/jetpack/${EXT_ID}/simple-storage/store.json"

    # FIXME(jeff): I would like to copy the configuration data directly to the
    # git repo and auto-commit the changes every time, but I'm not prepared to
    # spend the time writing and testing the script at the moment, so this'll
    # just have to do.
    BASE_CONFIG_FILE=$(basename "${PRIVACY_BADGER_CONFIG}")
    # cp -av ${PRIVACY_BADGER_CONFIG} \
      # "${WORKING_DIR}/config/firefox/${BASE_CONFIG_FILE}"
    BASE_CONFIG_FILE=$(basename "${PRIVACY_BADGER_CONFIG}")
    cp -av ${PRIVACY_BADGER_CONFIG} \
      "${HOME}/.config/firefox/${BASE_CONFIG_FILE}"
  }

  # Firefox addon: AdBlock
  ln -sf ${WORKING_DIR}/config/firefox/dials.ini ${HOME}/.config/firefox/dials.ini

  # Firefox addon: Privacy Badger
  ln -sf ${WORKING_DIR}/config/firefox/privacy-badger.json ${HOME}/.config/firefox/privacy-badger.json

  # Firefox addon: Speed Dial
  ln -sf ${WORKING_DIR}/config/firefox/CurrentSettings.ini ${HOME}/.config/firefox/CurrentSettings.ini
  ln -sf ${WORKING_DIR}/config/firefox/dials.ini ${HOME}/.config/firefox/dials.ini

  # Firefox addon: Tab Groups
  ln -sf ${WORKING_DIR}/config/firefox/tab-groups.json ${HOME}/.config/firefox/tab-groups.json
fi # end if firefox config is enabled

# ncmpcpp configuration
if [[ $(which ncmpcpp) ]]; then
  stow --ignore="${STOW_IGNORE_LIST}" -v ncmpcpp
fi

# NOTE(jeff): Create "legacy" convenience file links
ln -sf "${XDG_CONFIG_HOME}/git/config" \
  "${HOME}/.gitconfig"

# hg configuration
stow -v --ignore="${STOW_IGNORE_LIST}" hg

# tmux configuration
stow -v --ignore="${STOW_IGNORE_LIST}" tmux

# gtk configuration
stow --ignore="${STOW_IGNORE_LIST}" -v gtk

# pianobar cfg
stow -v pianobar

# emacs cfg
stow -v -d "${WORKING_DIR}" -t "${HOME}" emacs

# grc cfg
stow -v grc

# mpd && mpdscribble configuration
if [[ $(which mpd) ]]; then
  mkdir -pv "${XDG_CONFIG_HOME}/mpd"
  mkdir -v "${XDG_CONFIG_HOME}/mpd/cache"
  mkdir -v "${XDG_CONFIG_HOME}/mpd/log"
  mkdir -v "${XDG_CONFIG_HOME}/mpd/db"
  mkdir -v "${XDG_CONFIG_HOME}/mpd/tmp"

  stow --ignore="${STOW_IGNORE_LIST}" -v mpd

  # mpdscribble configuration
  if [[ $(which mpdscribble) ]]; then
    stow --ignore="${STOW_IGNORE_LIST}" -v mpdscribble
  fi
fi

case "$(uname -s)" in
Darwin)

  stow -v --ignore="${STOW_IGNORE_LIST}" osx

  stow -v --ignore="${STOW_IGNORE_LIST}" wakeonlan

  # iTerm configuration
  # See also: https://iterm2.com/shell_integration.html
  stow --ignore="${STOW_IGNORE_LIST}" -v iterm2.9

  # Mac OS X Automator Services
  # FIXME: Figure out an automated installation method for these files
  #if [[ -x "${HOME}/Library/Services" ]]; then
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Duplicate Tab.workflow" "${HOME}/Library/Services/Duplicate Tab.workflow"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/New File.workflow" "${HOME}/Library/Services/New File.workflow"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Toggle Hidden Files.workflow" "${HOME}/Library/Services/"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Zoom In.workflow" "${HOME}/Library/Services/Zoom In.workflow"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Zoom Out.workflow" "${HOME}/Library/Services/Zoom Out.workflow"
  #fi

  stow --ignore="${STOW_IGNORE_LIST}" -v mpd-osx
  stow --ignore="${STOW_IGNORE_LIST}" -v mpdscribble-osx

  # mpd daemon configuration
  if [[ $(which mpd) ]]; then
    launchctl unload "${HOME}/Library/LaunchAgents/org.local.mpd.plist"
    launchctl load "${HOME}/Library/LaunchAgents/org.local.mpd.plist"
    launchctl start "${HOME}/Library/LaunchAgents/org.local.mpd.plist"

    # mpdscribble daemon configuration
    if [[ "$(which mpdscribble)" ]]; then
      launchctl unload "${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist"
      launchctl load "${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist"
      launchctl start "${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist"
    fi

    if [[ -d "${XDG_MUSIC_DIR}" && -r "${XDG_MUSIC_DIR}" ]]; then
      ${LINK_COMMAND} -sf "${XDG_MUSIC_DIR}" "${XDG_CONFIG_HOME}/mpd/music"

      if [[ -d "${XDG_MUSIC_DIR}/playlists" && -r "${XDG_MUSIC_DIR}/playlists" ]]; then
        ${LINK_COMMAND} -sf "${XDG_MUSIC_DIR}/playlists" \
          ${XDG_CONFIG_HOME}/mpd/playlists
      fi
    fi # end if symlink
  fi # end if mpd

  # stow --ignore="${STOW_IGNORE_LIST}" -v synergy
  # stow --ignore="${STOW_IGNORE_LIST}" -v synergy-osx

  # unison
  if [[ "$(which unison)" ]]; then
    stow --ignore="${STOW_IGNORE_LIST}" -v unison
    stow --ignore="${STOW_IGNORE_LIST}" -v unison-osx

    launchctl unload \
      "${HOME}/Library/LaunchAgents/org.local.unison_nomlib.plist"
    launchctl unload \
      "${HOME}/Library/LaunchAgents/org.local.unison_nomdev.plist"
    launchctl unload \
      "${HOME}/Library/LaunchAgents/org.local.unison_ttcards.plist"
    launchctl unload \
      "${HOME}/Library/LaunchAgents/org.local.unison_third-party.plist"

    launchctl load \
      "${HOME}/Library/LaunchAgents/org.local.unison_nomlib.plist"
    launchctl load \
      "${HOME}/Library/LaunchAgents/org.local.unison_nomdev.plist"
    launchctl load \
      "${HOME}/Library/LaunchAgents/org.local.unison_ttcards.plist"
    launchctl load \
      "${HOME}/Library/LaunchAgents/org.local.unison_third-party.plist"
  fi

  # pow configuration
  stow -v pow

  # Hermes app helper script
  stow -v --ignore="${STOW_IGNORE_LIST}" hermes

  # Marked 2
  stow -v --ignore="${STOW_IGNORE_LIST}" marked

  # Sublime Text
  stow -v --ignore="${STOW_IGNORE_LIST}" sublime-text

  # API token keys
  #
  # NOTE(jeff): This file is sourced from .bashrc
  API_TOKENS_URL="https://www.dropbox.com/s/613qaye2ab70lpe/api_tokens?dl=0"
  curl -L -o "${HOME}/.api_tokens" "${API_TOKENS_URL}"

  # OpenAL-soft configuration
  stow -v --ignore="${STOW_IGNORE_LIST}" openal

  # ssh && sshd
  stow -v --ignore="${STOW_IGNORE_LIST}" ssh

  ;;
Linux)
  # stow -v samba

  # X11 configuration
  stow -v --ignore="${STOW_IGNORE_LIST}" X11
  ;;
*)
  # Catch-all
  ;;
esac

# NOTE(jeff): Install terminal emulation support for 256 colors, with italics.
#
# see tests/term_16colors.sh, tests/term_256colors.sh and tests/term_italics.sh
# to
# NOTE(jeff): Use the shell command 'toe' to verify termcaps installation
if [[ -x $(which tic) ]]; then
  tic "terminfo/screen-256color-italic.terminfo"  # tmux support
  tic "terminfo/xterm-256color-italic.terminfo"   # term, vim and everyone else
fi
