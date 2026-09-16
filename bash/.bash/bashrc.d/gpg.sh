# ~/.bash/bashrc.d/gpg.sh:jeff
#
# shellcheck shell=bash
#
# GPG init
#
# SEE ALSO
# 1. man gpg-agent
#

# IMPORTANT(JEFF): Ensure that we can use software that expects
# us to be able to unlock our GPG wallet from time to time, i.e.:
# `docker login`
if exists_exe gpg-agent &>/dev/null; then
  GPG_TTY=$(tty); export GPG_TTY
fi

