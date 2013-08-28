#!/bin/sh

WORKING_DIR=$(pwd)
RM_COMMAND=$(which rm)
LINK_COMMAND=$(which ln)

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

# mplayer configuration
${RM_COMMAND} -rv ${HOME}/.mplayer
