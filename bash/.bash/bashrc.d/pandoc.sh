# ~/.bash/bashrc.d/pandoc.sh:jeff
#
# Executed by bash(1) shell at
# the time of sourcing ~/.bashrc
#

[ -n "$DEBUG" ] && set -o errexit
[ -n "$DEBUG_TRACE" ] && set -o xtrace

[ -r "$HOME/.bash/lib" ] && . "$HOME/.bash/lib"

# pandoc env
#
# Generate BASH completions for Pandoc
if exists_exe pandoc &>/dev/null &&
  pandoc --bash-completion &>/dev/null; then
    eval "$(pandoc --bash-completion)"
fi

