#!/bin/bash

WORKING_DIR=$(pwd)
RM_COMMAND=$(which rm)

# vim configuration
${RM_COMMAND} -v $HOME/.vim/autoload
${RM_COMMAND} -v $HOME/.vim/bundle
${RM_COMMAND} -v $HOME/.vim/colors
${RM_COMMAND} -v $HOME/.vimrc

# mplayer configuration
${RM_COMMAND} -rv ${HOME}/.mplayer

# mpv configuration
${RM_COMMAND} -rv ${HOME}/.mpv

# git configuration
${RM_COMMAND} -rv $HOME/.gitattributes
${RM_COMMAND} -rv $HOME/.gitconfig
${RM_COMMAND} -rv $HOME/.gitignore_global
${RM_COMMAND} -rv $HOME/.gitk
${RM_COMMAND} -rv $HOME/.git_template

# hg configuration
${RM_COMMAND} -rv $HOME/.hgignore_global

# tmux configuration
${RM_COMMAND} -rv $HOME/.tmux.conf

# gtk configuration
${RM_COMMAND} -rv $HOME/.gtkrc-2.0
${RM_COMMAND} -rv $HOME/.gtkrc-2.0.mine

# X11 configuration
${RM_COMMAND} -rv $HOME/.Xresources

# pianobar cfg
${RM_COMMAND} -rv ${HOME}/.config/pianobar

# emacs cfg
${RM_COMMAND} -rv ${HOME}/.emacs

# grc cfg
${RM_COMMAND} -rv ${HOME}/.grc

case "$(uname -s)" in
Darwin)

  if [[ -x "${HOME}/local/bin" ]]; then
    # local support bins
    ${RM_COMMAND} -rv ${HOME}/local/bin/dotfiles
    ${RM_COMMAND} -rv ${HOME}/local/bin/gen-ssh-key
    ${RM_COMMAND} -rv ${HOME}/local/bin/subl
    ${RM_COMMAND} -rv ${HOME}/local/bin/Terminal
    ${RM_COMMAND} -rv ${HOME}/local/bin/wakeuplibra
    ${RM_COMMAND} -rv ${HOME}/local/bin/wakeupwindev
    ${RM_COMMAND} -rv ${HOME}/local/bin/Marked2.sh

    # iTerm2 integration
    if [[ -x "${HOME}/.iterm2_shell_integration.bash" ]]; then
      ${RM_COMMAND} -rv "${HOME}/.iterm2_shell_integration.bash"

      ${RM_COMMAND} -rv ${HOME}/local/bin/imgcat
      ${RM_COMMAND} -rv ${HOME}/local/bin/imgls
    fi
  fi

  # Mac OS X Automator Services
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/Duplicate Tab.workflow"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/New File.workflow"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/Zoom In.workflow"
  # ${RM_COMMAND} -rv "${HOME}/Library/Services/Zoom Out.workflow"

  # mpd, mpdscribble configuration
  #${RM_COMMAND} -rv ${HOME}/.config/mpd
  #${RM_COMMAND} -rv ${HOME}/.ncmpcpp
  if [[ $(which mpd) ]]; then
    launchctl stop ${HOME}/Library/LaunchAgents/org.local.mpd.plist
    launchctl unload ${HOME}/Library/LaunchAgents/org.local.mpd.plist
  fi

  if [[ $(which mpdscribble) ]]; then
    launchctl stop ${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist
    launchctl unload ${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist
  fi

  # synergys configuration
  # ${RM_COMMAND} -rv ${HOME}/.synergy.conf
  # ${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.synergys.plist
  ${RM_COMMAND} -rv ${HOME}/local/bin/synergys.sh

  # unison configuration
  launchctl unload ~/Library/LaunchAgents/org.local.unison_nomlib.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_nomdev.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_ttcards.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_third-party.plist

  ${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.unison_nomlib.plist
  ${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.unison_nomdev.plist
  ${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.unison_ttcards.plist
  ${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.unison_third-party.plist

  ${RM_COMMAND} -rv ${HOME}/local/bin/unison_nomlib.sh
  ${RM_COMMAND} -rv ${HOME}/local/bin/unison_nomdev.sh
  ${RM_COMMAND} -rv ${HOME}/local/bin/unison_ttcards.sh
  ${RM_COMMAND} -rv ${HOME}/local/bin/unison_third-party.sh

  # pow configuration
  ${RM_COMMAND} -rv ${HOME}/.powconfig

  # AppleScripts
  ${RM_COMMAND} -rv $HOME/local/bin/setaudio.applescript
  ${RM_COMMAND} -rv ${HOME}/local/bin/audiodevice
  ${RM_COMMAND} -rv $HOME/local/bin/AppleTV.applescript
  ${RM_COMMAND} -rv $HOME/local/bin/hermes

  # My registered GitHub API token for use on behalf of HomeBrew requests,
  # i.e.: brew search
  ${RM_COMMAND} -rv ${HOME}/.github_token

  ;;
Linux)
  exit 0
  ;;
*)
  exit 0
  ;;
esac

# Bash supporting configuration
${RM_COMMAND} -v $HOME/.colors

# Bash configuration
${RM_COMMAND} -v $HOME/.bash_aliases
${RM_COMMAND} -v $HOME/.bash_cflags
${RM_COMMAND} -v $HOME/.bash_login
${RM_COMMAND} -v $HOME/.bash_logout
${RM_COMMAND} -v $HOME/.bash_profile
${RM_COMMAND} -v $HOME/.bash_prompt
${RM_COMMAND} -v $HOME/.bash_syscheck
${RM_COMMAND} -v  $HOME/.bashlib
${RM_COMMAND} -v  $HOME/.bashrc
${RM_COMMAND} -v  $HOME/.inputrc
