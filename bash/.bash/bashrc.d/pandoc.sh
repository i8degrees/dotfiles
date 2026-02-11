# ~/.bash/bashrc.d/pandoc.sh:jeff
# shellcheck shell=bash
# Executed by bash(1) shell at
# the time of sourcing ~/.bashrc
#

[ -n "$DEBUG" ] && set -o errexit
[ -n "$DEBUG_TRACE" ] && set -o xtrace

# shellcheck disable=SC1091
[ -r "$HOME/.bash/lib" ] &&
  . "$HOME/.bash/lib"

# pandoc env
#
# Generate BASH completions for Pandoc
if exists_exe pandoc &>/dev/null &&
  pandoc --bash-completion &>/dev/null; then
    echo "INFO: Initializing pandoc BASH completions."
    echo
    eval "$(pandoc --bash-completion)"
else
  echo "WARN: pandoc executable is not available."
  echo
fi

