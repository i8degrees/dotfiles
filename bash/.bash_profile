#!/bin/bash
#
# 2011-08-24: jeff
#
#		~/.bash_profile
#
# Local bash (1) profile executed for login shells.
#

#if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then

#if [[ -n $(tty) ]]; then
#	command tmux
#fi

PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

case "$(uname -s)" in
	Darwin)
		PATH="$PATH:$HOME/Applications:/usr/X11/bin"
	;;
	Linux)
		PATH="/snap/bin:${HOME}/.config/feh/themes:$PATH:/usr/games"
	;;
	*)
	;;
esac

if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

umask 022

# rbenv env
if [[ -x "$(command -v rbenv)" ]]; then
  eval "$(rbenv init -)"
fi

# golang env
GOPATH="${HOME}/local/src/golang"; export GOPATH

if [[ ! (-d "${GOPATH}") ]]; then
  mkdir -p "${GOPATH}/bin" || exit 255
fi

GOBIN="${GOPATH}/bin"; export GOBIN
PATH="$GOBIN:$PATH"

# mkcert env
CAROOT="${HOME}/pki"; export CAROOT

# gtk2 env
#GTK_THEME="Adapta-Nokto"; export GTK_THEME

# bw env
BW_CLIENTSECRET="wIIQ2ao9wjtTHPivjualyZ7cf8eIrL"
BW_CLIENTID="user.030c456e-d385-4987-b831-acf0004f7a71"

BW_SESSION="qQ4CTs9rkCT25u/rOd6JJwIlWMSWGuxufmrV6uWrv7BctlTzqILuZU6LoAXsV7yhTuKph5/QOeJWLFe79p2REg=="; export BW_SESSION

# python3 env (pip)
PATH="$HOME/.local/bin:$PATH"

# pkg-config env
PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

# node env
eval "$(nodenv init -)"

# pulsar apm env
if [[ -d "/opt/Pulsar/resources/app/ppm/bin" ]]; then
  PATH="/opt/Pulsar/resources/app/ppm/bin:$PATH"
fi

[[ -d "/opt/android-sdk/platform-tools" ]] && PATH=/opt/android-sdk/platform-tools:$PATH

