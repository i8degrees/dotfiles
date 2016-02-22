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

case "$(uname -s)" in
  Darwin)
    PATH="${PATH}:$HOME/local/bin"; export PATH

    #PATH="$PATH:$HOME/local/src/emscripten"
    #export PATH

    # MacTex-basic package (used with pdfjam from brew)
    export PATH="$PATH:/usr/local/texlive/2013basic/bin/x86_64-darwin"

    TMPDIR="/private/tmp"; export TMPDIR

    # Use coreutils (brew package) commands with their normal names, AKA without
    # the default 'g' prefix. This means using GNU's tools instead of the
    # default provided BSD (OS X) tools.
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

    # Access coreutils (brew package) man pages with their normal names
    #MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

    # gnu-sed brew package
    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
  ;;
  Linux)
    export PATH="$HOME/local/bin:$PATH"
    TMPDIR="/tmp"; export TMPDIR
  ;;
  *)
  ;;
esac

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

BROWSER="google-chrome"; export BROWSER

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

case "$(uname -s)" in
  Darwin)
    if [ -f "$(which lesspipe.sh)" ]; then
      LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
    fi

    LESS="-r"; export LESS # color support

    if [ -f "$(which gdircolors)" ]; then
      eval "$(gdircolors -b $HOME/.bash/colors/dir_colors)"
    fi

    # homebrew/bash-completion
    # Third-party user-land app completions for BASH
    if [[ -f "${LOCAL_SITE_PREFIX}/etc/bash_completion" ]]; then
      source "${LOCAL_SITE_PREFIX}/etc/bash_completion"
    fi

    # homebrew/bash-completion2
    # if [[ -f "${LOCAL_SITE_PREFIX}/share/bash-completion/bash_completion" ]]; then
      # . "${LOCAL_SITE_PREFIX}/share/bash-completion/bash_completion"
    # fi

    #SSH_ASKPASS="/usr/local/libexec/ssh-askpass"; export SSH_ASKPASS
    #SUDO_ASKPASS="/usr/local/libexec/ssh-askpass"; export SUDO_ASKPASS

    GIT_ASKPASS=/usr/local/bin/git-credential-osxkeychain; export GIT_ASKPASS
  ;;
  Linux)
    if [ -f "$(which lesspipe)" ]; then
      eval "$(lesspipe)"
    fi

    eval "$(dircolors -b $HOME/.bash/colors/dir_colors)"

    # XDG CONFIG DIRS (Xorg FreeDesktop standard)
    if [ -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs ]; then
      . ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
    fi

    if [ -f ${XDG_DOCUMENTS_DIR:-~/.config}/user-dirs.dirs ]; then
      . ${XDG_DOCUMENTS_DIR:-~/.config}/user-dirs.dirs
    fi

    export XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR XDG_TEMPLATES_DIR
    export XDG_PUBLICSHARE_DIR XDG_MUSIC_DIR
    export XDG_PICTURES_DIR XDG_VIDEOS_DIR

    SciTE_HOME="/home/jeff/.scite"; export SciTE_HOME

    if [[ -r "/etc/bash_completion" ]]; then
      source /etc/bash_completion
    fi

    #SSH_ASKPASS=""; export SSH_ASKPASS
    #SUDO_ASKPASS=""; export SUDO_ASKPASS
  ;;
  *)
  ;;
esac

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
