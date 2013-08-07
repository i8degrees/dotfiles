#!/bin/sh

WORKING_DIR=$(pwd)
LINK_COMMAND=$(which ln)

${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_aliases $HOME/.bash_aliases
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_cflags $HOME/.bash_cflags
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_login $HOME/.bash_login
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_logout $HOME/.bash_logout
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_profile $HOME/.bash_profile
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_prompt $HOME/.bash_prompt
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bash_syscheck $HOME/.bash_syscheck
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bashlib $HOME/.bashlib
${LINK_COMMAND} -sf ${WORKING_DIR}/bash/bashrc $HOME/.bashrc
