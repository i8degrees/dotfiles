#!/bin/sh
#
# 2011-07-20:jeff
#
# 		~/.bashrc
#
# Local interactive bash (1) shell config.
#

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

# Our bash (1) history file
export HISTFILE="$HOME/.bash_history"

# 8,192 Bytes or 8.1K history cap size
export HISTFILESIZE=8192

# TODO: need to verify this is the same as above.
export HISTSIZE="$HISTFILESIZE"

# Do not put duplicate lines in the history.
export HISTCONTROL=ignoredups

if [ -f "$HOME/.bash_cflags" ]; then
	. "$HOME/.bash_cflags"
else
	echo -e "ERR: Ensure that $HOME/.bash_cflags file permissions are executable (x) and readable (r)."
fi

if [ -f "$HOME/.bashlib" ]; then
	. "$HOME/.bashlib"
else
	echo -e "ERR: Ensure that $HOME/.bashlib file permissions are executable (x) and readable (r)."
fi

if [ -f "$HOME/.bash_prompt" ]; then
	. "$HOME/.bash_prompt"
else
	echo -e "ERR: Ensure that $HOME/.bash_prompt file permissions are executable (x) and readable (r)."
fi

# NOTE:	The following line *must* be included before the repo GCC toolchain bins
#		path is set
#PATH="/usr/lib/colorgcc/bin"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

case "$(uname -s)" in
	Darwin)
		PATH="$PATH:/usr/X11/bin"
	;;
	Linux)
		PATH="$PATH:$HOME/.config/feh/themes"
	;;
	*)
	;;
esac

PATH="$HOME/.rbenv/shims:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

if [ -f "$(which rbenv)" ]; then
	eval "$(rbenv init -)"
fi

if [ -f "$(which locale)" ]; then
	eval "$(locale)"
fi
#eval "$(resize)"

#export USECOLOR=true
export TERM=xterm-256color
TMPDIR="/tmp"; export TMPDIR
BLOCKSIZE=K; export BLOCKSIZE
INPUTRC="/etc/inputrc"; export INPUTRC

BROWSER="google-chrome"; export BROWSER
EDITOR="vim"; export EDITOR
VISUAL="vim"; export VISUAL

case "$(uname -s)" in
	Darwin)
		#TERMINAL="iTerm2"; export TERMINAL

		if [ -f "$(which lesspipe.sh)" ]; then
			eval "$(lesspipe.sh)"
		fi

		if [ -f "$(which gdircolors)" ]; then
			eval "$(gdircolors -b $HOME/.colors/dir_colors)"
		fi

		if [ -f `brew --prefix`/etc/bash_completion ]; then
    		. `brew --prefix`/etc/bash_completion
    	else
			echo -e "ERR: Ensure that $(which brew) --prefix /etc/bash_completion file permissions are executable (x) and readable (r)."
		fi
	;;
	Linux)	
		TERMINAL="urxvtc"; export TERMINAL

		if [ -f "$(which lesspipe)" ]; then
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

		MINICOM="-m -c on"; export MINICOM
		MPD_HOST="666@libra"; export MPD_HOST
		SSH_KEYS="$HOME/.ssh/id"; export SSH_KEYS

		if [ -f "/etc/bash_completion" ]; then
			. /etc/bash_completion
		else
			echo -e "ERR: Ensure that /etc/bash_completion file permissions are executable (x) and readable (r)."
		fi
	;;
	*)		
	;;
esac

# Additional Bash(1) inclusion files

if [ -f "/etc/bash_completion.d/git" ]; then
	. /etc/bash_completion.d/git
else
	echo -e "ERR: Ensure that /etc/bash_completion.d/git file permissions are executable (x) and readable (r)."
fi

if [ -f "$HOME/.bash_aliases" ]; then
	. $HOME/.bash_aliases
else
	echo -e "ERR: Ensure that $HOME/.bash_aliases file permissions are executable (x) and readable (r)."
fi
