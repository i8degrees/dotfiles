# ~/.bash/bashrc.d/bat.sh:jeff
#
# shellcheck shell=bash
#
# Bat Theme
#
# SEE ALSO
# 1. bat --help
#

if exists_exe bat &>/dev/null; then
  BAT_THEME="$HOME/.config/bat/themes/Human++.tmTheme"
fi

