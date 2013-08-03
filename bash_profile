#!/bin/sh
#
# 2011-08-24: jeffrey.carp@gmail.com
#
#		~/.bash_profile
#
# Local bash (1) profile executed for login shells.
#

#if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then

#if [[ -n $(tty) ]]; then
#	command tmux
#fi

PATH="/usr/local/bin:$HOME/Applications/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

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

if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

umask 022