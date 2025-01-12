#!/bin/bash
# ~/.bashrc:jeff
#
# Executed by bash(1) for non-login (non-interactive) shell requests
#

# IMPORTANT(JEFF): Do not source this file when we are not in an
# interactive shell -- this resolves termination issues when using
# SSH utilities like scp, ~/.ssh/rc and so forth and what have you!
[ -z "$PS1" ] && return

[ -n "$DEBUG" ] && set -o errexit
[ -n "$DEBUG_TRACE" ] && set -o xtrace

# NOTE(JEFF): Control bit for how to handle deprecated bits herein.
# The default shall always be NOT TO and thus must be set explicitly
# with, or without a value.
#
# TODO(JEFF): Relocate this env bit to a more appropiate place; perhaps
# in our local BASH environment conditional includes -- none of that
# has been commited to git, though, as of yet.
#USE_DEPRECATED=0

# NOTE(JEFF): Control bit for how to handle everything I deem 
# "experimental"; this is more like occasionally used environments
# that I wish not to normally propagate for whatever reason.
#
# TODO(JEFF): Relocate this env bit to a more appropiate place; perhaps
# in our local BASH environment conditional includes -- none of that
# has been commited to git, though, as of yet.
USE_EXPERIMENTAL=0

# NOTE(JEFF): Control bit for whether to set file limits via ulimit;
# I am undecided as to how I wish to do this, as I often have done so
# via sysctl and other such methods, but... simplicity is the ideal
# state for many things as some old adage goes!
#
# TODO(JEFF): Relocate this env bit to a more appropiate place; perhaps
# in our local BASH environment conditional includes -- none of that
# has been commited to git, though, as of yet.
#USE_FILE_LIMITS=0 # ulimit based

# NOTE(JEFF): Control bit for whether to allow enabling ZFS administrative
# scripts, even as root -- this is STRONGLY ill advised, but such is my
# life, so fuck off; this is what our snapshots, checkpoints and most 
# importantly, proper system backups are for, right? :]
#
# TODO(JEFF): Relocate this env bit to a more appropiate place; perhaps
# in our local BASH environment conditional includes -- none of that
# has been commited to git, though, as of yet.
#USE_ZFS_ADMIN=0

if [ -x "$HOME/.bash_prompt" ]; then
  . "$HOME/.bash_prompt"
fi

# IMPORTANT(jeff): Do not close the terminal with the CTRL+D key stroke!
IGNOREEOF=4 # set -o ignoreeof

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If true, .bash_history is appended at logout rather than overwritten as per
# the defaults.
shopt -s histappend

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

# Automatically prepend `cd` when only a path is given as a shell command
shopt -s autocd

# Do not allow existing regular files to be overwritten by redirection of
# shell output.
set -o noclobber

# Our bash (1) history file
export HISTFILE="$HOME/.bash_history"

# Set a maximum capacity of 16.384 KB (or 16384 lines) of heap storage
# for our BASH history logs.
export HISTFILESIZE=16384 # 16.384 KB

# TODO: need to verify this is the same as above.
export HISTSIZE="$HISTFILESIZE"

# 1. Remove all but the last identical command
# 2. Avoid saving commands that begin with a space
export HISTCONTROL="erasedups:ignorespace"

# Linux)
# NOTE: The following line *must* be included before the repo GCC toolchain bins
#   path is set
#PATH="/usr/lib/colorgcc/bin"

# Reset aliases to ensure consistent state upon environment reload; see my
# rbash alias.
unalias -a # Remove all alias definitions

if [ -n "$(command -v locale)" ]; then
  eval "$(locale)"
  # IMPORTANT(JEFF): Under no certain condition shall I ever wish to NOT
  # see my clock timestamps in 24-hour. Especially relevant now that
  # it is not uncommon to be working in multiple timezones at the same
  # time where you must correlate log timestamps and such...
  #
  # TLDR; Fuck 12 hour timestamps. Seriously, dude -- burn all such clocks
  # out of existance for they are now OBSOLETE and should never need reference
  # to ever again, lest you wish to make serious time calculation mistakes...
  # I mean, that's never happened before, right? Hmmph, oh, that's right; Y2K
  # already happened and now we near yet another DOOM AND GLOOM Y2K in 2038
  # when your 64-bit counters shall overflow. Same story, different day...
  [[ ! "$LC_TIME" =~ /C.UTF-8/ ]] && LC_TIME="C.UTF-8"; export LC_TIME
fi

# NOTE: Initial PATH environment is set in ~/.bash_profile.

# NOTE(jeff): This is recommended as per the EXAMPLE of Section 1 of the
# manual page for which; man 1 which
#which() {
  #(alias; declare -f) | /usr/bin/which --tty-only --read-alias \
    #--read-functions --show-tilde --show-dot $@
  #}
#export -f which

case "$(uname -s)" in
  Darwin)
    PATH="$HOME/local/bin:$PATH"
    export PATH

    #PATH="$PATH:$HOME/local/src/emscripten"
    #export PATH

    # MacTex-basic package (used with pdfjam from brew)
    export PATH="$PATH:/usr/local/texlive/2013basic/bin/x86_64-darwin"

    #if [ "$(which aless)" ]; then
      #PAGER="aless"; export PAGER
      #MAN_PAGER="aless"; export MAN_PAGER;
    #fi

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
    PATH="$HOME/bin:$HOME/local/bin:$PATH"
    #TMPDIR="/tmp"
  ;;
  *)
  ;;
esac

#TMPDIR="$HOME/tmp"
VIM_BIN="$(command -v vim)"
VIMTINY_BIN="$(command -v vim.tiny)"
# TODO(JEFF): The `subl` script replaces all of the following editor
# logic you see below. It has yet to be fully commited into the git
# tree, though.
SUBL_BIN="$(command -v subl)"

if [[ -x "$VIMTINY_BIN" ]]; then
  EDITOR=$VIMTINY_BIN
elif [[ -x "$VIM_BIN" ]]; then
  EDITOR=$VIM_BIN
fi

if [ -z "$EDITOR" ]; then
  export EDITOR
fi

if [ -n "$SUBL" ]; then
  VISUAL="$EDITOR"
fi

export VISUAL

if [ -n "$USE_DEPRECATED" ]; then
  # DEPRECATED(JEFF): The nvim environment is being considered for removal
  # due to lack of use.
  if [[ "$EDITOR" == "/usr/bin/nvim" || "$EDITOR" == "/usr/bin/neovim" ]]; then
    VIM="$HOME/.nvim/nvimrc"; export VIM
  fi
fi

VISUAL_EDITOR="$(which subl)"
export VISUAL_EDITOR

#export USECOLOR=true
if [ -x "$(command -v toe)" ] && [ -x "$(command -v grep)" ]; then
  # FIXME(jeff): Figure out how we can support this termcap on any machine --
  # this will resolve the "unknown terminal" issue we have.
  [ ! "$(toe|grep -q -i -e 'screen-256color-italic')" ] && TERM="screen-256color-italic"
  [ ! "$(toe|grep -q -i -e 'xterm')" ] && TERM="xterm"
  [ ! "$(toe|grep -q -i -e 'xterm-256color')" ] && TERM="xterm-256color"
  [ ! "$(toe|grep -q -i -e 'tmux')" ] && TERM="tmux"
  [ ! "$(toe|grep -q -i -e 'tmux-256color')" ] && TERM="tmux-256color"
else
  TERM="linux"
fi

[ -n "$TERM" ] && export TERM
TERM=screen-256color-italic

# TMPDIR="/tmp"; export TMPDIR
#TMPDIR="$HOME/tmp"; export TMPDIR
BLOCKSIZE=K; export BLOCKSIZE

# stow readline
[ -f "$HOME/.inputrc" ] && INPUTRC="$HOME/.inputrc"
if [ "$SHELL" = "/bin/bash" ] && [ -n "$INPUTRC" ]; then
  bind -f "$INPUTRC"
fi

#if [ "$(which vimpager)" ]; then
#fi

# browser env
if [ -n "$(command -v google-chrome)" ]; then
  BROWSER="google-chrome"
elif [ -n "$(command -v firefox-bin)" ]; then
  # TODO(JEFF): Ugh, is this the correct binary name for Firefox? Geez,
  # thanks, I feel old now... Firebird, err Phoenix -- Nutscape!
  BROWSER="firefox-bin"
elif [ -n "$(command -v elinks)" ]; then
  # sensible-browser refers to this environment variable
  BROWSER="elinks"
fi

if [ -n "$BROWSER" ]; then
  export BROWSER
fi

# All things serial comms env
if [ -n "$(command -v minicom)" ]; then
  MINICOM="-m -c on"; export MINICOM
elif [ -n "$(command -v tio)" ]; then
  true # STUB(JEFF): Future implementation detail...
fi

# mpd env
if [ -n "$(command -v mpd)" ]; then
  MPD_HOST="$HOME/.config/mpd/socket"
  #MPD_HOST="777@~/.config/mpd/socket"
fi

if [ -n "$MPD_HOST" ]; then
  export MPD_HOST
fi

# ssh env
# IMPORTANT(JEFF): Please always use ed25519 cipher except in specified
# edge cases stated below!
SSH_KEYS_PRIMARY="$HOME/.ssh/id_ed25519" # conditional file include

# WARNING(JEFF): RSA keys are sometimes the only viable option when dealing
# with ancient or even somewhat modern embedded platforms. Neither of which
# should EVER be reachable by the internet, mind you as RSA 1024 bit keys
# are now vulnerable to attack!
SSH_KEYS_BACKUP="$HOME/.ssh/id_rsa" # conditional file include
SSH_KEYS_GITHUB="$HOME/.ssh/id_ed25519-github" # conditional file include

if [ -e "$SSH_KEYS_PRIMARY" ]; then
  SSH_KEYS="$SSH_KEYS:$SSH_KEYS_PRIMARY"
fi

if [ -e "$SSH_KEYS_BACKUP" ]; then
  SSH_KEYS="$SSH_KEYS:$SSH_KEYS_BACKUP"
fi

if [ -e "$SSH_KEYS_GITHUB" ]; then
  SSH_KEYS="$SSH_KEYS:$HOME/.ssh/id_ed25519-github" 
fi

if [ -n "$SSH_KEYS" ]; then
  export SSH_KEYS
fi

case "$(uname -s)" in
  Darwin)
    if [ -f "$(command -v lesspipe.sh)" ]; then
      LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
    fi

    LESS="-r"; export LESS # color support

    if [ -f "$(which gdircolors)" ]; then
      eval "$(gdircolors -b $HOME/.colors/dir_colors)"
    fi

    # homebrew/versions/bash_completion2
    if [[ -f "/usr/local/share/bash-completion/completions" ]]; then
      . /usr/local/etc/bash_completion.d
      . /usr/local/share/bash-completion/completions
    fi

    #SSH_ASKPASS="/usr/local/libexec/ssh-askpass"; export SSH_ASKPASS
    #SUDO_ASKPASS="/usr/local/libexec/ssh-askpass"; export SUDO_ASKPASS

    # brew search, info, ... uses the GitHub Web API that is often exceeded
    # without a Personal Access Token
    if [ -f ${HOME}/.github_token ]; then
      . ${HOME}/.github_token
    fi

    export GIT_ASKPASS=/usr/local/bin/git-credential-osxkeychain
  ;;
  Linux)

    LS_OPTIONS='--color=auto'; export LS_OPTIONS
    eval "$(dircolors)"

    if [ -f "$(command -v lesspipe)" ]; then
      eval "$(lesspipe)"
    fi

    eval "$(dircolors -b $HOME/.colors/dir_colors)"

    # NOTE(JEFF): XDG CONFIG DIRS; a FreeDesktop standard
    # When we want to mutate `XDG_CONFIG_DIRS`, we must do so via
    # inclusion of inside of `~/.config/user-dirs.dirs`, else
    # undesirable things are likely to occur!
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
      . /etc/bash_completion
    fi

    #SSH_ASKPASS=""; export SSH_ASKPASS
    #SUDO_ASKPASS=""; export SUDO_ASKPASS
  ;;
  *)
  ;;
esac

# ruby env
if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"

  RUBY_PREFIX_PATH="$(rbenv prefix)"
  if [ -d "${RUBY_PREFIX_PATH}/bin" ]; then
    PATH="${RUBY_PREFIX_PATH}/bin:$PATH"
  fi

  SHIMS_PREFIX_PATH="$(rbenv root)/shims"
  [ -d "$SHIMS_PREFIX_PATH" ] && PATH="${SHIMS_PREFIX_PATH}:$PATH"
fi

# perl env
# PATH="/home/jeff/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/home/jeff/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/.cpan/build/lib/perl5"; export PERL_LOCAL_LIB_ROOT
# PERL_LOCAL_LIB_ROOT="$HOME/.cpan/build/lib/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/.cpan/build/lib/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/.cpan/build/lib/perl5"; export PERL_MM_OPT;
PERL_CPANM_OPT="--notest installdeps"; export PERL_CPANM_OPT
# Module::Install options
PERL_AUTOINSTALL='--skipdeps'; export PERL_AUTOINSTALL

# proxmox-backup-client env
XDG_STATE_HOME="$HOME/.config"; export XDG_STATE_HOME

# Additional bash scripts to include in local site configuration

if [ -x "$HOME/.bash_aliases" ]; then
  . "$HOME/.bash_aliases"
fi

if [ -x "$HOME/.bash_cflags" ]; then
  . "$HOME/.bash_cflags"
fi

if [ -x "$HOME/.bashlib" ]; then
  . "$HOME/.bashlib"
fi

if [ -x "$HOME/.bash_completions" ]; then
  . "$HOME/.bash_completions"
fi

# ssh env
#
# SEE ALSO
# 1. ~/.tmux.conf
#

# NOTE(JEFF): Conditional branch for whether we are already inside a tmux
# session or not -- this is very important to always resolve!
#
# TODO(JEFF): Rename the SSH auth socket file to `~/.ssh/agent` or so ASAP
#SSH_AUTH_FILE="$HOME/.ssh/agent"

SSH_AUTH_FILE="$HOME/.ssh/ssh_auth_sock"
if [ -z ${TMUX+x} ]; then
  if [ ! -S "$SSH_AUTH_FILE" ] && [ -S "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" "$SSH_AUTH_FILE"
  fi
else # tmux session
  SSH_AUTH_SOCK="$SSH_AUTH_FILE"; export SSH_AUTH_SOCK
fi

if [ -n "$USE_EXPERIMENTAL" ]; then
  RCLONE_CONFIG="$HOME/.config/rclone/rclone.conf"; export RCLONE_CONFIG
fi

# maximum open files and related env
if [ -n "$USE_FILE_LIMITS" ]; then
  # adjust open files limit for this user's env
  [ -n "$(command -v ulimit)" ] && ulimit -n 65535
fi

# rust env
CARGO_BIN="$(command -v cargo)"
CARGO_ENV_FILE="$HOME/.cargo/env"
if [ -n "$CARGO_BIN" ]; then
  [ -f "$CARGO_ENV_FILE" ] && . "$CARGO_ENV_FILE"
fi

# ZFS env
if [ -n "$USE_ZFS_ADMIN" ]; then
  ZPOOL_SCRIPTS_AS_ROOT=1; export ZPOOL_SCRIPTS_AS_ROOT
fi

