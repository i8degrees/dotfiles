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
