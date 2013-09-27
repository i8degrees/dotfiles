#!/bin/sh

WORKING_DIR=$(pwd)
MKDIR_COMMAND=$(which mkdir)
LINK_COMMAND=$(which ln)

# vim configuration
${MKDIR_COMMAND} -p ${HOME}/.vim
${MKDIR_COMMAND} -p ${HOME}/.vim/backup
${MKDIR_COMMAND} -p ${HOME}/.vim/tmp
${LINK_COMMAND} -sf ${WORKING_DIR}/vim/autoload/ $HOME/.vim/autoload
${LINK_COMMAND} -sf ${WORKING_DIR}/vim/bundle/ $HOME/.vim/bundle
${LINK_COMMAND} -sf ${WORKING_DIR}/vim/colors/ $HOME/.vim/colors
${LINK_COMMAND} -sf ${WORKING_DIR}/vim/vimrc $HOME/.vimrc

# Bash supporting configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/colors/ $HOME/.colors

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

# mplayer configuration
${LINK_COMMAND} -sf ${WORKING_DIR}/mplayer/ $HOME/.mplayer

# mpd configuration
${MKDIR_COMMAND} -p ${HOME}/.config/mpd
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/cache
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/log
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/db
${MKDIR_COMMAND} -p ${HOME}/.config/mpd/tmp
${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/mpd.conf $HOME/.config/mpd/mpd.conf
#${LINK_COMMAND} -sf ${WORKING_DIR}/mpd/mpdscribble.conf $HOME/.config/mpd/mpdscribble.conf

case "$(uname -s)" in
Darwin)
  if [ -d "/Volumes/Music" ]; then
    ${LINK_COMMAND} -sf /Volumes/Music/ $HOME/.config/mpd/music

    if [ -d "/Volumes/Music/playlists" ]; then
      ${LINK_COMMAND} -sf /Volumes/Music/playlists/ $HOME/.config/mpd/playlists
    fi
  else
    if [ -d "$HOME/Music" ]; then
      ${LINK_COMMAND} -sf $HOME/Music/ $HOME/.config/mpd/music

      if [ -d "$HOME/Music/playlists" ]; then
        ${LINK_COMMAND} -sf $HOME/Music/ $HOME/.config/mpd/music
      fi
    fi
  fi
  ;;
Linux)
  return 0
  ;;
*)
  return 0
  ;;
esac
