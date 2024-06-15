#!/bin/bash
#
# 2011-08-24: jeff
#
#		~/.bash_profile
#
# Local bash (1) profile executed for login shells.
#
# Append "$1" to $PATH when not already in.
# This function API is accessible to scripts in /etc/profile.d

append_path() {
  case ":$PATH:" in
    *:"$1":*)
      ;;
    *)
      PATH="${PATH:+$PATH:}$1"
  esac
}

#if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then

#if [[ -n $(tty) ]]; then
#	command tmux
#fi

#PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

case "$(uname -s)" in
	Darwin)
		PATH="$PATH:$HOME/Applications:/usr/X11/bin"
	;;
	Linux)
    PATH="${HOME}/.config/feh/themes:$PATH:/usr/games"
	;;
	*)
	;;
esac

if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

umask 022

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

# rbenv env
if [[ -x "$(which -v rbenv)" ]]; then
  eval "$(rbenv init -)"
fi

if [ -d "/home/jeff/.local/share/gem/ruby/3.0.0/bin" ]; then
  PATH="/home/jeff/.local/share/gem/ruby/3.0.0/bin:$PATH"
fi

# pulsar apm env
if [[ -d "/opt/Pulsar/resources/app/ppm/bin" ]]; then
  PATH="$PATH:/opt/Pulsar/resources/app/ppm/bin"
fi

[[ -d "/opt/android-sdk/platform-tools" ]] && PATH=/opt/android-sdk/platform-tools:$PATH

# homebrew env
#
# Set PATH, MANPATH, etc., for Homebrew.
#
# IMPORTANT(jeff): It is important that we put the binaries from brew **last**
# in our PATH environment. Otherwise, you will start executing common utilities
# from the wrong system!
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:"; export MANPATH
INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"; export INFOPATH
#append_path "/home/linuxbrew/.linuxbrew/bin"
#append_path "/home/linuxbrew/.linuxbrew/sbin"

HOMEBREW_GITHUB_API_TOKEN="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"; export HOMEBREW_GITHUB_API_TOKEN

#QT_LOGGING_RULES="kwin_*.debug=true"; export QT_LOGGING_RULES

# node env
eval "$(nodenv init - --no-rehash)"
NODE_BUILD_DEFINITIONS="${HOMEBREW_PREFIX}/opt/node-build-update-defs/share/node-build"; export NODE_BUILD_DEFINITIONS

# pkg-config env
PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib32/pkgconfig:/usr/share/pkgconfig:${HOMEBREW_PREFIX}/lib"; export PKG_CONFIG_PATH

# dotnet env
# 1. https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#set-environment-variables-system-wide
DOTNET_ROOT="/usr/share/dotnet"; export DOTNET_ROOT
DOTNET_HOST_PATH="/usr/share/dotnet/dotnet"; export DOTNET_HOST_PATH

[ -d "$DOTNET_ROOT" ] && PATH="$DOTNET_ROOT:${DOTNET_ROOT}/tools:$PATH"

# java appmenu
_JAVA_OPTIONS="${_JAVA_OPTIONS} -javaagent:/usr/share/java/jayatanaag.jar"; export _JAVA_OPTIONS
JAYATANA_FORCE=1; export JAYATANA_FORCE=1
