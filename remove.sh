#!/bin/sh

WORKING_DIR=$(pwd)
RM_COMMAND=$(which rm)

# vim configuration
${RM_COMMAND} -v $HOME/.vim/autoload
${RM_COMMAND} -v $HOME/.vim/bundle
${RM_COMMAND} -v $HOME/.vim/colors
${RM_COMMAND} -v $HOME/.vimrc

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

# mplayer configuration
${RM_COMMAND} -rv ${HOME}/.mplayer

# mpd configuration
${RM_COMMAND} -rv ${HOME}/.config/mpd

# synergys configuration
${RM_COMMAND} -rv ${HOME}/.synergy.conf
${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.synergys.plist
${RM_COMMAND} -rv ${HOME}/local/bin/synergys.sh

# unison configuration
launchctl unload ~/Library/LaunchAgents/org.local.unison_nomlib.plist
launchctl unload ~/Library/LaunchAgents/org.local.unison_nomdev.plist
launchctl unload ~/Library/LaunchAgents/org.local.unison_ttcards.plist

${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.unison_nomlib.plist
${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.unison_nomdev.plist
${RM_COMMAND} -rv ${HOME}/Library/LaunchAgents/org.local.unison_ttcards.plist

${RM_COMMAND} -rv ${HOME}/local/bin/unison_nomlib.sh
${RM_COMMAND} -rv ${HOME}/local/bin/unison_nomdev.sh
${RM_COMMAND} -rv ${HOME}/local/bin/unison_ttcards.sh

# pow configuration
${RM_COMMAND} -rv ${HOME}/.powconfig
