#!/bin/bash
#
# 2016-02/21:jeff
#
# Local interactive Bash (1) shell config

# check the window size after each command; updates LINES and COLUMNS
shopt -s checkwinsize

shopt -u mailwarn
unset MAILCHECK

shopt -s cdable_vars

# if true, Bash paths include dotfiles when the wildcard * is specified. If false, one must explicitly select dot files by specifiying .*
shopt -s dotglob

# if true, aliases are expanded
shopt -s expand_aliases

# if true, extend the pattern matching featureset
#shopt -s extglob

# if true, attempt to perform hostname tab completion
shopt -s hostcomplete

# if true, minor spelling errors of a dir component in a cd will be corrected
shopt -s cdspell

# Append Bash history at logout (defaults to overwritten)
shopt -s histappend

# Our bash (1) history file
export HISTFILE="${HOME}/.bash/history"

# Maximum of 16384 lines storable in our history file
export HISTFILESIZE=8192

# TODO: need to verify this is the same as above.
export HISTSIZE="$HISTFILESIZE"

# Do not put duplicate lines in the history.
export HISTCONTROL=ignoredups

# Linux)
# NOTE: The following line *must* be included before the repo GCC toolchain bins
#   path is set
#PATH="/usr/lib/colorgcc/bin"

# Reset aliases to ensure consistent state upon environment reload; see my
# rbash alias.
unalias -a # Remove all alias definitions

if [ -x "$(which locale)" ]; then
  eval "$(locale)"
fi

# NOTE: Initial PATH environment is set in ~/.bash_profile.

# export EDITOR='subl -w' # Do not exit editor until file is closed
if [[ $(which vim) ]]; then
  export EDITOR=$(which vim)
  export VISUAL=$EDITOR
fi

#eval "$(resize)"

export TERM=xterm-256color-italic
#TMPDIR="$HOME/tmp"; export TMPDIR
BLOCKSIZE=K; export BLOCKSIZE
export INPUTRC="$HOME/.inputrc"

BROWSER="firefox"; export BROWSER

MINICOM="-m -c on"; export MINICOM
export MPD_HOST="666@${HOSTNAME}"
SSH_KEYS="$HOME/.ssh/libra_dsa"; export SSH_KEYS

# IMPORTANT(jeff): Setup our app API token keys via environment configuration
# file. In particular, it is important that we have an API key registered
# homebrew -- its search feature can quickly hit the lower request limits
# imposed by non-token account holders.
if [[ -r "${HOME}/.api_tokens" ]]; then
  source "${HOME}/.api_tokens"
fi

if [ -f "$(which lesspipe.sh)" ]; then
  LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
fi

LESS="-r"; export LESS # color support

if [ -f "$(which lesspipe)" ]; then
  eval "$(lesspipe)"
fi

if [ -f "$(which gdircolors)" ]; then
  eval "$(gdircolors -b $HOME/.bash/colors/dir_colors)"
fi

# Additional bash scripts to include
if [[ -r "${HOME}/.bash/prompt" ]]; then
  source "${HOME}/.bash/prompt"
fi

if [[ -r "${HOME}/.bash/user_functions" ]]; then
  source "${HOME}/.bash/user_functions"
fi

if [[ -r "${HOME}/.bash/aliases" ]]; then
  source "${HOME}/.bash/aliases"
fi

# Added by the Heroku Toolbelt
if [[ $(which /usr/local/heroku/bin/heroku) ]]; then
  PATH=$PATH:/usr/local/heroku/bin; export PATH
fi

# added by travis gem
[ -f /Users/jeff/.travis/travis.sh ] && source /Users/jeff/.travis/travis.sh
