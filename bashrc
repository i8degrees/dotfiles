# 2011-07-20:jeff
#
# 		~/.bashrc
#
#   Local bash (1) profile executed for interactive (non-login) shells.
#

# Check for an interactive session -- returns from this file if shell is not
[ -z "$PS1" ] && return

eval "$(locale)"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If true, .bash_history is appended at logout rather than overwritten as per
# the defaults.
shopt -s histappend

# Our bash (1) history file
export HISTFILE="$HOME/.bash_history"

# 8,192 Bytes or 8.1K history cap size
export HISTFILESIZE=8192

# TODO: need to verify this is the same as above.
export HISTSIZE="$HISTFILESIZE"

# Do not put duplicate lines in the history.
export HISTCONTROL=ignoredups

if [ -f "/usr/local/bin/lesspipe" ]; then
	eval "$(lesspipe)"
else
	echo -e "ERR: Ensure that file permissions are executable (x) and readable (r)."
fi

# fielding.dotfiles color schema
if [ "$COLORTERM" ]; then
    eval "$(dircolors -b $HOME/.colors/.dir_colors)"
fi

if [ -f "$HOME"/.bash_cflags ]; then
	. "$HOME"/.bash_cflags
else
	echo -e "ERR: Ensure that file permissions are executable (x) and readable (r)."
fi

if [ -f "$HOME"/.bashlib ]; then
	. "$HOME"/.bashlib
else
	echo -e "ERR: Ensure that file permissions are executable (x) and readable (r)."
fi

if [ -f "$HOME"/.bash_prompt ]; then
	. "$HOME"/.bash_prompt
else
	echo -e "ERR: Ensure that file permissions are executable (x) and readable (r)."
fi

# NOTE:	The following line *must* be included before the repo GCC toolchain bins
#		path is set

#PATH="/usr/lib/colorgcc/bin"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
PATH="$HOME/.config/feh/themes:$PATH"
export PATH

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

eval "$(rbenv init -)"
#eval "$(resize)"

export TERM=xterm-256color
export TMPDIR="/tmp"
export BLOCKSIZE=K
export INPUTRC="/etc/inputrc"
#export USECOLOR=true

TERMINAL="/usr/bin/urxvtc"; export TERMINAL
BROWSER="/usr/bin/google-chrome"; export BROWSER
EDITOR="vim"; export EDITOR
VISUAL="scite"; export VISUAL

# XDG CONFIG DIRS (Xorg FreeDesktop standard)
if [ -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs ]; then
	. ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
fi

#if [ -f ${XDG_DOCUMENTS_DIR:-~/.config}/user-dirs.dirs ]; then
#	. ${XDG_DOCUMENTS_DIR:-~/.config}/user-dirs.dirs
#fi

    export XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR XDG_TEMPLATES_DIR
    export XDG_PUBLICSHARE_DIR XDG_MUSIC_DIR
    export XDG_PICTURES_DIR XDG_VIDEOS_DIR

MINICOM="-m -c on"; export MINICOM
export MPD_HOST="666@libra"
export SSH_KEYS=$HOME/.ssh/id
export SciTE_HOME="/home/jeff/.scite"

#export RECOLL_CONFDIR="$HOME/.recoll"
#export TAGXFS_REPOSITORY=~/.tags
#export SDL_VIDEO_FULLSCREEN_DISPLAY=0

# Bash(1) inclusion files

if [ -r "/etc/bash_completion" ]; then
	. /etc/bash_completion
fi

if [ -r "/etc/bash_completion.d/git" ]; then
	. /etc/bash_completion.d/git
fi

if [ -f "$HOME"/.bash_aliases ]; then
	. $HOME/.bash_aliases
else
	echo -e "ERR: Ensure that file permissions are executable (x) and readable (r)."
fi


