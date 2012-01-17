# 2011-07-20:jeff
#
# 		~/.bashrc
#
#   Local bash (1) profile executed for interactive (non-login) shells.
#

# Check for an interactive session
[ -z "$PS1" ] && return

# NOTE:	The following line *must* be included before the repo GCC toolchain bins
#		path is set
PATH="/usr/lib/colorgcc/bin:$PATH"
#PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
PATH="$HOME/bin:$PATH"
PATH="$HOME/.config/feh/themes:$PATH"
export PATH

shopt -u mailwarn
unset MAILCHECK
shopt -s checkwinsize

eval "$(/usr/bin/resize)"
eval "$(locale)"
#eval "$(rbenv init -)"

export TERM=xterm-256color
export TMPDIR="/tmp"
export BLOCKSIZE=K
export INPUTRC="/etc/inputrc"
#export USECOLOR=true

# fielding.dotfiles color schema
if [ "$COLORTERM" ]; then
    eval $(dircolors -b ~/.colors/.dir_colors)
fi

. "$HOME"/.bash_prompt

TERMINAL="/usr/bin/urxvtc"; export TERMINAL
BROWSER="/usr/bin/google-chrome"; export BROWSER
EDITOR="$(which vim)"; export EDITOR
VISUAL="$(which scite)"; export VISUAL

# XDG CONFIG DIRS (Xorg FreeDesktop standard)
if [ -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs ]; then
    . ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
    export XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR XDG_TEMPLATES_DIR
    export XDG_PUBLICSHARE_DIR XDG_DOCUMENTS_DIR XDG_MUSIC_DIR
    export XDG_PICTURES_DIR XDG_VIDEOS_DIR
fi

MINICOM="-m -c on"; export MINICOM
export MPD_HOST="666@libra"
export SSH_KEYS=$HOME/.ssh/id
export SciTE_HOME="/home/jeff/.scite"
#export RECOLL_CONFDIR="$HOME/.recoll"
#export TAGXFS_REPOSITORY=~/.tags

#export SDL_VIDEO_FULLSCREEN_DISPLAY=0

# bash(1) include files

[ -r /etc/bash_completion   ] && . /etc/bash_completion

. "$HOME"/.bash_cflags
. "$HOME"/.bash_aliases
. "$HOME"/.bashlib
