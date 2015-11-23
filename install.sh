#!/bin/bash

WORKING_DIR=$(pwd)
MKDIR_COMMAND=$(which mkdir)
# FIXME: Do **not** use BSD ln, as it does not have the -T switch, which
# means some of these symbolic links will not be installed correctly!
LINK_COMMAND=$(which ln)
COPY_COMMAND=$(which cp)
TMUX_COMMAND=$(which tmux)
GRC_COMMAND=$(which grc)

# vim configuration
${MKDIR_COMMAND} -p "${HOME}/.vim"

# NOTE: These two directories should be kept local to the machine
${MKDIR_COMMAND} -p "${HOME}/.vim/backup"
${MKDIR_COMMAND} -p "${HOME}/.vim/tmp"

${LINK_COMMAND} -sfT "${WORKING_DIR}/vim/autoload $HOME/.vim/autoload"
${LINK_COMMAND} -sfT "${WORKING_DIR}/vim/bundle $HOME/.vim/bundle"
${LINK_COMMAND} -sfT "${WORKING_DIR}/vim/colors $HOME/.vim/colors"
${LINK_COMMAND} -sf "${WORKING_DIR}/vim/vimrc $HOME/.vimrc"

CTAGS_BIN="$(which ctags)"

if [[ ! -x $CTAGS_BIN ]]; then
  echo "WARNING: Exuberant CTags must be installed for vim-tagbar functionality."
fi

# Bash supporting configuration
${LINK_COMMAND} -sfT "${WORKING_DIR}/colors" "$HOME/.colors"

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

# mpd configuration
if [[ $(which mpd) ]]; then
  ${MKDIR_COMMAND} -p ${HOME}/.config/mpd
  ${MKDIR_COMMAND} -p ${HOME}/.config/mpd/cache
  ${MKDIR_COMMAND} -p ${HOME}/.config/mpd/log
  ${MKDIR_COMMAND} -p ${HOME}/.config/mpd/db
  ${MKDIR_COMMAND} -p ${HOME}/.config/mpd/tmp
  ${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/mpd.conf $HOME/.config/mpd/mpd.conf
fi

# mpdscribble configuration
if [[ $(which mpdscribble) ]]; then
  ${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/mpdscribble.conf $HOME/.config/mpd/mpdscribble.conf
fi

# ncmpcpp configuration
if [[ $(which mpdscribble) ]]; then
  ${MKDIR_COMMAND} -p ${HOME}/.ncmpcpp
  ${LINK_COMMAND} -sfT ${WORKING_DIR}/ncmpcpp/config ${HOME}/.ncmpcpp/config
  ${LINK_COMMAND} -sfT ${WORKING_DIR}/ncmpcpp/bindings ${HOME}/.ncmpcpp/bindings
fi

# synergys configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/synergy/synergy.conf $HOME/.synergy.conf

# git configuration
${LINK_COMMAND} -sf "${WORKING_DIR}/git/gitattributes" "$HOME/.gitattributes"
${LINK_COMMAND} -sf "${WORKING_DIR}/git/gitconfig" "$HOME/.gitconfig"
${LINK_COMMAND} -sf "${WORKING_DIR}/git/gitignore_global" "$HOME/.gitignore_global"
${LINK_COMMAND} -sf "${WORKING_DIR}/git/gitk" "$HOME/.gitk"
${LINK_COMMAND} -sfT "${WORKING_DIR}/git/hooks" "$HOME/.git_template"

# hg configuration
${LINK_COMMAND} -sf "${WORKING_DIR}/hg/hgignore_global" "$HOME/.hgignore_global"

# tmux configuration
if [[ -x "${TMUX_COMMAND" ]]; then
  ${MKDIR_COMMAND} -p "${HOME}/.tmux/plugins"
  ${GIT_COMMAND} clone "https://github.com/tmux-plugins/tpm" "${HOME}/.tmux/plugins/tpm"
  ${LINK_COMMAND} -sf "${WORKING_DIR}/tmux/.tmux.conf" "$HOME/.tmux.conf"
  if [[ ( -n "${TMUX}") && ( -x "${TMUX_COMMAND}") && ( -f "${HOME}/.tmux.conf") ]]; then
    "${TMUX_COMMAND}" source "${HOME}/.tmux.conf"
  fi
else
  echo "INFO(jeff): The tmux package is not installed. 
  echo "\t sudo apt install tmux tmux-plugin-manager"
  echo
  echo "This script will not link the configuration files until the binary can be found."
fi

# gtk2 configuration
${LINK_COMMAND} -sf "${WORKING_DIR}/gtk2/gtkrc-2.0" "$HOME/.gtkrc-2.0"
${LINK_COMMAND} -sf "${WORKING_DIR}/gtk2/gtkrc-2.0.mine" "$HOME/.gtkrc-2.0.mine"

# gtk3 configuration
${MKDIR_COMMAND} -p "${HOME}/.config/gtk-3.0/"
${LINK_COMMAND} -sf ${WORKING_DIR}/gtk3/.config/gtk-3.0/ $HOME/.config/gtk-3.0/

# X11 configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/X11/Xresources $HOME/.Xresources

# pianobar cfg
${MKDIR_COMMAND} -p ${HOME}/.config/pianobar
${LINK_COMMAND} -sf ${WORKING_DIR}/pianobar/config ${HOME}/.config/pianobar/config

# emacs cfg
${LINK_COMMAND} -sf ${WORKING_DIR}/emacs/emacs ${HOME}/.emacs

# grc cfg
if [[ -x "${GRC_COMMAND}" ]]; then
  if [[ ! (-L "${HOME}/.grc") ]]; then
    ${LINK_COMMAND} -sf "${WORKING_DIR}/grc" "${HOME}/.grc"
  fi
else
  echo "INFO(jeff): The grc package is not installed. 
  echo "\t sudo apt install grc"
  echo
  echo "This script will not link the configuration files until the binary can be found."
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
    ${LINK_COMMAND} -sf ${WORKING_DIR}/local/bin/wakeuplibra ${HOME}/local/bin/wakeuplibra
    ${LINK_COMMAND} -sf ${WORKING_DIR}/local/bin/wakeupwindev ${HOME}/local/bin/wakeupwindev
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
  if [[ $(which mpd) ]]; then
    ${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/org.local.mpd.plist $HOME/Library/LaunchAgents/org.local.mpd.plist

    launchctl unload ${HOME}/Library/LaunchAgents/org.local.mpd.plist
    launchctl load ${HOME}/Library/LaunchAgents/org.local.mpd.plist
    launchctl start ${HOME}/Library/LaunchAgents/org.local.mpd.plist

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
    fi # end if symlink
  fi # end if mpd

  # mpdscribble configuration
  if [[ $(which mpdscribble) ]]; then
    ${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/org.local.mpdscribble.plist $HOME/Library/LaunchAgents/org.local.mpdscribble.plist
    launchctl unload ${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist
    launchctl load ${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist
    launchctl start ${HOME}/Library/LaunchAgents/org.local.mpdscribble.plist
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

# Install 256 color terminal support with italic glyphs added
if [[ -x $(which tic) ]]; then
  tic terminfo/screen-256color-italic.terminfo
  tic terminfo/xterm-256color-italic.terminfo

  # NOTE: Use the shell command 'toe' to verify that the termcap is usable
fi
