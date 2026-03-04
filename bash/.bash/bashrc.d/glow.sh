# ~/.bash/bashrc.d/glow.sh:jeff
#
# shellcheck shell=bash
#
# Glow Shell Integration
#
# SEE ALSO
# 1. glow completion
#

if exists_exe glow &>/dev/null; then
  eval "$(glow completion bash)"
fi

