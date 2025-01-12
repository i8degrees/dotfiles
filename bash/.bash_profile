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
  # shellcheck disable=SC1091
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

# bitwarden env
# FIXME(JEFF): Certificate validation fails validation with both step-ca [2]
# and the Bitwarden cmd, bw [2].
#
# 1. step certificate verify ~/.config/Bitwarden\ CLI/fullchain.pem
#
# 2. bw login
#   * request to https://vault.mynaughty.party/identity/accounts/prelogin failed
#   with the first certificate failing validation; this would be the
#   vault.mynaughty.party certificate from fullchain.pem
if [ -n "$(command -v bw)" ]; then
  #BW_CLIENTSECRET="wIIQ2ao9wjtTHPivjualyZ7cf8eIrL"
  #BW_CLIENTID="user.030c456e-d385-4987-b831-acf0004f7a71"
  BW_SESSION="qQ4CTs9rkCT25u/rOd6JJwIlWMSWGuxufmrV6uWrv7BctlTzqILuZU6LoAXsV7yhTuKph5/QOeJWLFe79p2REg=="; export BW_SESSION

  # setup the necessary certificates for our custom vault location;
  # upon stowing the "bitwarden-cli" package from our dotfiles.git repo,
  # this path will be created for you automatically.
  if [ -e "$HOME/.config/Bitwarden\ CLI/fullchain.pem" ]; then
    NODE_EXTRA_CA_CERTS="$HOME/.config/Bitwarden\ CLI/fullchain.pem:$NODE_EXTRA_CA_CERTS"
  fi
fi

# python3 env (pip)
PATH="$HOME/.local/bin:$PATH"

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


#QT_LOGGING_RULES="kwin_*.debug=true"; export QT_LOGGING_RULES

# NodeJS env
#
# (void) setup_node_env(str = required)
# ...where str is a non-zero array of characters to say what NodeJS version
# manager binary to prefer in setting up all of this.
#
# TODO(JEFF): Consider removing this logic entirely as we never have gotten
# around to exploring other version managers, such as NVM. Doubtful that 
# I ever will, either, considering that all outstanding nodenv issues
# have since been resolved now...
NODENV_COMPLETIONS="/usr/lib/nodenv/libexec/completions/nodenv.bash"

setup_node_env() {
  bin="$1"
  args="- --no-rehash"

  if [ ! -x "$HOME/.nodenv/bin/nodenv" ]; then
    return
  fi

  [ -n "$(command -v "$bin")" ] && eval "$($bin init "$args")"
  [ -e "$HOME/.nodenv/bin" ] && append_path "$HOME/.nodenv/bin"
  [ -e "$HOME/.nodenv/shims" ] && PATH="$HOME/.nodenv/shims:$PATH"
  # shellcheck disable=SC1090
  [ -e "$NODENV_COMPLETIONS" ] && . "$NODENV_COMPLETIONS"

  [ -n "$HOMEBREW_PREFIX" ] && NODE_BUILD_DEFINITIONS="${HOMEBREW_PREFIX}/opt/node-build-update-defs/share/node-build"; export NODE_BUILD_DEFINITIONS
}

#NODENV_SHELL=bash; export NODENV_SHELL

# DEPRECATED(JEFF): What is all this??? I do not recall when I wrote this command alias
# for nodenv. Therefore I feel as though I should treat it as pending removal.
# shellcheck disable=SC2160
if [ ! true ]; then
  echo "WARNING: This branch is intended never to execute and thus something is wrong if you see this message..."
  echo
  command nodenv rehash 2>/dev/null
  nodenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
      rehash|shell)
      eval "$(nodenv "sh-$command" "$@")"
    ;;
    *)
      command nodenv "$command" "$@"
    ;;
    esac
  }
fi

# pkg-config env
PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib32/pkgconfig:/usr/share/pkgconfig:${HOMEBREW_PREFIX}/lib"; export PKG_CONFIG_PATH

# dotnet env
# 1. https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#set-environment-variables-system-wide
DOTNET_ROOT="/usr/share/dotnet"; export DOTNET_ROOT
DOTNET_HOST_PATH="/usr/share/dotnet/dotnet"; export DOTNET_HOST_PATH

[ -d "$DOTNET_ROOT" ] && PATH="$DOTNET_ROOT:${DOTNET_ROOT}/tools:$PATH"

# java appmenu
#JAVA_OPTIONS="${JAVA_OPTIONS} -javaagent:/usr/share/java/jayatanaag.jar"; export JAVA_OPTIONS
# valapanel appmenu patch
JAYATANA_FORCE=1; export JAYATANA_FORCE=1

# wezterm env
if [[ -d "/opt/wezterm/bin" ]] && [[ -e "/opt/wezterm/bin/wezterm" ]]; then
  append_path "/opt/wezterm/bin"
fi

# flexbv env
if [ -d "$HOME/local/opt/flexbv" ]; then
  append_path "$HOME/local/opt/flexbv"
fi

# node env
setup_node_env nodenv

