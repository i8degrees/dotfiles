#!/usr/bin/env bash
#
#

[ -e "$HOME/.bash/lib" ] && . "$HOME/.bash/lib"

[ -x "$(exists_exe yamllint)" ] && alias yamllint='yamllint --no-warnings'
