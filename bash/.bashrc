#!/bin/bash
#
# 2011-07-20:jeff
#
#     ~/.bashrc
#
# Local interactive bash (1) shell config.
#

# node environment setup
#setup_node_env(str)
setup_node_env() {
  bin="$1"
  [ -x "$bin" ] && eval "$(nodenv init -)"
  if [ -e "$HOME/.nodenv/shims" ]; then
    PATH=$HOME/.nodenv/shims:$PATH
  fi
}

[ -z "$PS1" ] && return

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

# Maximum of 16384 lines storable in our history file
export HISTFILESIZE=8192

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

if [ -x "$(which locale)" ]; then
  eval "$(locale)"
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



    setup_node_env nodenv
  ;;
  *)
  ;;
esac

#TMPDIR="$HOME/tmp"
VIM_BIN="$(command -v vim)"
VIMTINY_BIN="$(command -v vim.tiny)"
NEOVIM_BIN="$(command -v nvim)"
SUBL_BIN="$(command -v subl)"
ATOM_BIN="$(command -v atom)"
NVIM_BIN=$NEOVIM_BIN

if [[ -x "$NEOVIM_BIN" ]]; then
  EDITOR=$NEOVIM_BIN
fi

if [[ -x "$VIMTINY_BIN" ]]; then
  EDITOR=$VIMTINY_BIN
elif [[ -x "$VIM_BIN" ]]; then
  EDITOR=$VIM_BIN
elif [[ -x "$NVIM_BIN" ]]; then
  EDITOR=$NVIM_BIN;
fi

if [ -z "$EDITOR" ]; then
  export EDITOR
fi

if [ -n "$SUBL" ]; then
  VISUAL="$EDITOR"
fi

export VISUAL
#if [[ -x "$ATOM_BIN" ]]; then
  #VISUAL=$ATOM_BIN; export VISUAL
#elif [[ -x "$SUBL_BIN" ]]; then
  # VISUAL="subl -w" # Do not exit editor until file is closed
  #VISUAL=$SUBL_BIN; export VISUAL
#fi

if [[ "$EDITOR" == "/usr/bin/nvim" || "$EDITOR" == "/usr/bin/neovim" ]]; then
  VIM="$HOME/.nvim/nvimrc"; export VIM
fi

#VISUAL_EDITOR="$(which pulsar)"
VISUAL_EDITOR="$(which subl)"
export VISUAL_EDITOR

#eval "$(resize)"

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

BROWSER="google-chrome"; export BROWSER

MINICOM="-m -c on"; export MINICOM
MPD_HOST="666@/home/jeff/.config/mpd/socket"
#MPD_HOST="777@~/.config/mpd/socket"
#MPD_HOST="666@localhost"
export MPD_HOST
SSH_KEYS="$HOME/.ssh/libra_dsa"; export SSH_KEYS

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
    if [ -f "$(command -v lesspipe)" ]; then
      eval "$(lesspipe)"
    fi

    eval "$(dircolors -b $HOME/.colors/dir_colors)"

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
# FIXME(JEFF): We need to finish setting this up before we make this live in
# the repo.
#
# SEE ALSO
# 1. ~/.tmux.conf
#
# Not in a TMUX session
if [ -z ${TMUX+x} ]; then
  if [ ! -S ~/.ssh/ssh_auth_sock ] && [ -S "$SSH_AUTH_SOCK" ]; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
  fi
else
  # # In TMUX session
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi
