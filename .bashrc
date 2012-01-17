# 2011-07-20:jeff
#
# 		~/.bashrc
#
#   Local bash (1) profile executed for non-login interactive shells.
#

# Check for an interactive session
[ -z "$PS1" ] && return

#eval /usr/bin/resize

export PS1='\[\033[0;32m\][`date +'%H:%M:%S'`] \[\033[0;34m\]\u\[\033[0;31m\]@\[\033[0;33m\]\h\[\033[0;34m\]:\[\033[00;36m\]\w\[\033[0;33m\] $\[\033[0m\] '

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=xterm-256color
export TERMINAL="/usr/bin/urxvtc"
export BROWSER="/usr/bin/google-chrome"
export EDITOR="$(which vim)"
export VISUAL="$(which scite)"
export BLOCKSIZE=K
export TMPDIR=/tmp
export INPUTRC=/etc/inputrc
#export CARCH=""
#export CHOST=""
export CFLAGS="-march=i686 -mtune=generic -O2 -pipe -fstack-protector -D_FORTIFY_SOURCE=2"
export CXXFLAGS=$CFLAGS
#export LDFLAGS="-W1,-O1,--sort-common,--as-needed,-z,relro,--hash-style=gnu"
export MAKEFLAGS="-j3"
export PREFIX="/usr/local"
#FIXME/TODO: eval /etc/makepkg.conf
export RUBYOPT="-W1 -rubygems"
export PATH="$HOME/.rbenv/bin"
export MINICOM="-m -c on"
#export USECOLOR=true

if [ -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs ]; then
    . ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
    export XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR XDG_TEMPLATES_DIR
    export XDG_PUBLICSHARE_DIR XDG_DOCUMENTS_DIR XDG_MUSIC_DIR
    export XDG_PICTURES_DIR XDG_VIDEOS_DIR
fi

export PATH="$HOME/bin:$PATH"
export PATH="/sbin:$PATH"
export PATH="$HOME/.config/feh/themes:$PATH"
export PATH="/usr/lib/colorgcc/bin:$PATH"
export MPD_HOST="666@libra"
export SSH_AUTH_KEY=$HOME/.ssh/id
export SciTE_HOME="/home/jeff/.scite"
export LANG="en_US.utf8"
shopt -u mailwarn
unset MAILCHECK
shopt -s checkwinsize
export TAGXFS_REPOSITORY=~/.tags
export RECOLL_CONFDIR="$HOME/.recoll"
#export SDL_VIDEO_FULLSCREEN_DISPLAY=0

# fielding.dotfiles color schema
if [ "$COLORTERM" ]; then
    eval $(dircolors -b ~/.colors/.dir_colors)
fi

eval "$(rbenv init -)"

. "${HOME}"/.bash_aliases
. "${HOME}"/.bashlib
