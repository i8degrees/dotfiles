#!/bin/bash

WORKING_DIR=$(pwd)
MKDIR_COMMAND=$(which mkdir)
# FIXME: Do **not** use BSD ln, as it does not have the -T switch, which
# means some of these symbolic links will not be installed correctly!
LINK_COMMAND=$(which ln)
COPY_COMMAND=$(which cp)

# vim configuration
${MKDIR_COMMAND} -p ${HOME}/.vim

# NOTE: These two directories should be kept local to the machine
${MKDIR_COMMAND} -p ${HOME}/.vim/backup
${MKDIR_COMMAND} -p ${HOME}/.vim/tmp

${LINK_COMMAND} -sfT ${WORKING_DIR}/vim/autoload $HOME/.vim/autoload
${LINK_COMMAND} -sfT ${WORKING_DIR}/vim/bundle $HOME/.vim/bundle
${LINK_COMMAND} -sfT ${WORKING_DIR}/vim/colors $HOME/.vim/colors
${LINK_COMMAND} -sf ${WORKING_DIR}/vim/vimrc $HOME/.vimrc

CTAGS_BIN="$(which ctags)"

if [[ ! -x $CTAGS_BIN ]]; then
  echo "WARNING: Exuberant CTags must be installed for vim-tagbar functionality."
fi

# Bash supporting configuration
${LINK_COMMAND} -sfT ${WORKING_DIR}/colors $HOME/.colors

# Bash scripts
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_aliases $HOME/.bash_aliases
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_cflags $HOME/.bash_cflags
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_login $HOME/.bash_login
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_logout $HOME/.bash_logout
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_profile $HOME/.bash_profile
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_prompt $HOME/.bash_prompt
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_syscheck $HOME/.bash_syscheck
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bashlib $HOME/.bashlib
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bashrc $HOME/.bashrc
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/inputrc $HOME/.inputrc

# mplayer configuration
#${LINK_COMMAND} -sf ${WORKING_DIR}/mplayer/ $HOME/.mplayer

# mpv player configuration
${MKDIR_COMMAND} -p ${HOME}/.mpv ${HOME}/.mpv/watch_later
${LINK_COMMAND} -sfT ${WORKING_DIR}/mpv/config $HOME/.mpv/config
${LINK_COMMAND} -sfT ${WORKING_DIR}/mpv/input.conf $HOME/.mpv/input.conf
${LINK_COMMAND} -sfT ${WORKING_DIR}/mpv/kq.profile $HOME/.mpv/kq.profile
${LINK_COMMAND} -sfT ${WORKING_DIR}/mpv/subs.profile $HOME/.mpv/subs.profile

# mpd, mpdscribble configuration
${MKDIR_COMMAND} -p ${HOME}/.config/mpd
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/cache
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/log
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/db
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/tmp
${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/mpd.conf $HOME/.config/mpd/mpd.conf
${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/mpdscribble.conf $HOME/.config/mpd/mpdscribble.conf
${MKDIR_COMMAND} -p ${HOME}/.ncmpcpp
${LINK_COMMAND} -sfT ${WORKING_DIR}/ncmpcpp/config ${HOME}/.ncmpcpp/config
${LINK_COMMAND} -sfT ${WORKING_DIR}/ncmpcpp/bindings ${HOME}/.ncmpcpp/bindings

# synergys configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/synergy/synergy.conf $HOME/.synergy.conf

# git configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/git/gitattributes $HOME/.gitattributes
${LINK_COMMAND} -sf ${WORKING_DIR}/git/gitconfig $HOME/.gitconfig
${LINK_COMMAND} -sf ${WORKING_DIR}/git/gitignore_global $HOME/.gitignore_global
${LINK_COMMAND} -sf ${WORKING_DIR}/git/gitk $HOME/.gitk
${LINK_COMMAND} -sfT ${WORKING_DIR}/git/hooks $HOME/.git_template

# hg configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/hg/hgignore_global $HOME/.hgignore_global

# tmux configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/tmux/tmux.conf $HOME/.tmux.conf

# gtk configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0
${LINK_COMMAND} -sf ${WORKING_DIR}/gtk/gtkrc-2.0.mine $HOME/.gtkrc-2.0.mine

# X11 configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/X11/Xresources $HOME/.Xresources

# pianobar cfg
${MKDIR_COMMAND} -p ${HOME}/.config/pianobar
${LINK_COMMAND} -sf ${WORKING_DIR}/pianobar/config ${HOME}/.config/pianobar/config

# emacs cfg
${LINK_COMMAND} -sf ${WORKING_DIR}/emacs/emacs ${HOME}/.emacs

# grc cfg
if [[ ! (-L ${HOME}/.grc) ]]; then
  ${LINK_COMMAND} -sf ${WORKING_DIR}/grc ${HOME}/.grc
fi

case "$(uname -s)" in
Darwin)

  # Ensure that expected environment folders are present
  if [[ ! -d "$HOME/local/bin" ]]; then
    mkdir -p $HOME/local/bin
  fi

  # local support bins
  if [[ -x "${HOME}/local/bin" ]]; then
    ${LINK_COMMAND} -sf ${WORKING_DIR}/local/bin/dotfiles ${HOME}/local/bin/dotfiles
    ${LINK_COMMAND} -sf ${WORKING_DIR}/local/bin/gen-ssh-key ${HOME}/local/bin/gen-ssh-key
    ${LINK_COMMAND} -sf ${WORKING_DIR}/local/bin/subl ${HOME}/local/bin/subl
    ${LINK_COMMAND} -sf ${WORKING_DIR}/local/bin/Terminal ${HOME}/local/bin/Terminal
  fi

  # iTerm2 integration
  if [[ -x "${HOME}/local/bin" ]]; then
    CURL_BIN=$(which curl)
    if [[ -x "${CURL_BIN}" && ! -f "${HOME}/.iterm2_shell_integration.bash" ]]; then
      curl -L https://iterm2.com/misc/install_shell_integration.sh
    fi
    ${LINK_COMMAND} -sf ${WORKING_DIR}/iterm/bin/imgcat ${HOME}/local/bin/imgcat
    ${LINK_COMMAND} -sf ${WORKING_DIR}/iterm/bin/imgls ${HOME}/local/bin/imgls
  fi

  # Mac OS X Automator Services
  # FIXME: Figure out an automated installation method for these files
  #if [[ -x "${HOME}/Library/Services" ]]; then
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Duplicate Tab.workflow" "${HOME}/Library/Services/Duplicate Tab.workflow"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/New File.workflow" "${HOME}/Library/Services/New File.workflow"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Toggle Hidden Files.workflow" "${HOME}/Library/Services/"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Zoom In.workflow" "${HOME}/Library/Services/Zoom In.workflow"
    #${LINK_COMMAND} -sf "${WORKING_DIR}/osx/services/Zoom Out.workflow" "${HOME}/Library/Services/Zoom Out.workflow"
  #fi

  # mpd configuration
  if [ -d "/Volumes/Media/Music" ]; then
    ${LINK_COMMAND} -sf /Volumes/Media/Music $HOME/.config/mpd/music

    if [ -d "/Volumes/Media/Music/playlists" ]; then
      ${LINK_COMMAND} -sf /Volumes/Media/Music/playlists/ $HOME/.config/mpd/playlists
    fi
  else
    if [ -d "$HOME/Music" ]; then
      ${LINK_COMMAND} -sf $HOME/Music/ $HOME/.config/mpd/music

      if [ -d "$HOME/Music/playlists" ]; then
        ${LINK_COMMAND} -sf $HOME/Music/ $HOME/.config/mpd/music
      fi
    fi
  fi

  # FIXME: synergys launchd script
  ${LINK_COMMAND} -sf ${WORKING_DIR}/synergy/synergys.sh $HOME/local/bin/synergys.sh
  #${LINK_COMMAND} -sf ${WORKING_DIR}/synergy/org.local.synergys.plist $HOME/Library/LaunchAgents/org.local.synergys.plist
  #launchctl unload ~/Library/LaunchAgents/org.local.synergys.plist
  #launchctl load ~/Library/LaunchAgents/org.local.synergys.plist

  # unison launchd script
  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/unison_nomlib.sh $HOME/local/bin/unison_nomlib.sh
  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/unison_nomdev.sh $HOME/local/bin/unison_nomdev.sh
  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/unison_ttcards.sh $HOME/local/bin/unison_ttcards.sh
  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/unison_third-party.sh $HOME/local/bin/unison_third-party.sh

  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/org.local.unison_nomlib.plist $HOME/Library/LaunchAgents/org.local.unison_nomlib.plist
  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/org.local.unison_nomdev.plist $HOME/Library/LaunchAgents/org.local.unison_nomdev.plist
  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/org.local.unison_ttcards.plist $HOME/Library/LaunchAgents/org.local.unison_ttcards.plist
  ${LINK_COMMAND} -sf ${WORKING_DIR}/unison/org.local.unison_third-party.plist $HOME/Library/LaunchAgents/org.local.unison_third-party.plist

  launchctl unload ~/Library/LaunchAgents/org.local.unison_nomlib.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_nomdev.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_ttcards.plist
  launchctl unload ~/Library/LaunchAgents/org.local.unison_third-party.plist

  launchctl load ~/Library/LaunchAgents/org.local.unison_nomlib.plist
  launchctl load ~/Library/LaunchAgents/org.local.unison_nomdev.plist
  launchctl load ~/Library/LaunchAgents/org.local.unison_ttcards.plist
  launchctl load ~/Library/LaunchAgents/org.local.unison_third-party.plist

  # pow configuration
  ${LINK_COMMAND} -sf ${WORKING_DIR}/powconfig $HOME/.powconfig

  # Convenience helper script for setting default audio routing to Internal Output
  ${LINK_COMMAND} -sf ${WORKING_DIR}/AppleScript/setaudio.applescript $HOME/local/bin/setaudio

  # Helper script for AirParrot that activates AppleTV's "Extended Desktop"
  # feature at user login
  ${LINK_COMMAND} -sf ${WORKING_DIR}/AppleScript/AppleTV.applescript $HOME/local/bin/AppleTV.applescript

  # Hermes app helper script
  ${LINK_COMMAND} -sf ${WORKING_DIR}/AppleScript/hermes.applescript $HOME/local/bin/hermes

  # My registered GitHub API token for use on behalf of HomeBrew requests,
  # i.e.: brew search
  #
  # NOTE: This file is sourced from my .bashrc
  curl -L -o ${HOME}/.github_token https://www.dropbox.com/s/zfqyfvvcu7upf9b/github_token?dl=0

  ;;
Linux)
  exit 0
  ;;
*)
  exit 0
  ;;
esac

# Install 256 color terminal support with italic glyphs added; this requires
# a terminal that supports italic text
if [[ -x $(which tic) && -f "./terminfo/screen-256color-italic.terminfo" ]]; then
    tic terminfo/screen-256color-italic.terminfo

    # NOTE: Use the shell command 'toe' to verify that
    # 'screen-256color-italic' has been installed.
fi
