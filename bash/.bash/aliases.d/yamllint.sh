#!/usr/bin/env bash
#
#

[ -e "$HOME/.bash/lib" ] && . "$HOME/.bash/lib"

if exists_exe yamllint &>/dev/null; then
  alias yamllint='yamllint --no-warnings'
fi
