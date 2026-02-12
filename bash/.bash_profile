#!/usr/bin/env bash
#
#		~/.bash_profile:jeff
#
# Local bash (1) profile executed for login shells.
#

# IMPORTANT(JEFF): This is a workaround to allow us back the scrollbuffer
# without further customization.
export MOSH_ENABLE_SCROLLBACK=1

# shellcheck disable=SC1091
[ -e "$HOME/.bash/lib" ] && . "$HOME/.bash/lib"

#if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then

#if [[ -n $(tty) ]]; then
#	command tmux
#fi

#PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

umask 022
# IMPORTANT(JEFF): Do not relocate the following snippet as we must source
# this particular script before anything else; we initialize our environment
# by clearing all the existing aliases, etc in this file.
if [ -f "$HOME/.bashrc" ]; then
  # shellcheck disable=SC1091
  [ -z "$DEBUG" ] && . "$HOME/.bashrc"
fi

# NOTE(JEFF): BASH alias snippets from the user (opt-in)
if [ -d "$HOME/.bash/aliases.d" ]; then
  for i in "$HOME/.bash/aliases.d"/*.sh; do
    if [[ -r "$i" ]] && [[ -x "$i" ]]; then
      [ -n "$DEBUG" ] && echo "$i"
      # shellcheck disable=SC1090
      . "$i"
    fi
  done
  unset i
fi

case "$(uname -s)" in
  Darwin)
    PATH="$PATH:$HOME/Applications:/usr/X11/bin"
  ;;
  Linux)
    # NOTE(JEFF): OpenWRT && FreshTomato system PATH
    [ -r "/path" ] && . "/path"

    # feh env
    [ -r "$HOME/.config/feh/themes" ] && append_path "$HOME/.config/feh/themes"

    # Local user's script env...
    [ -r "$HOME/bin" ] && append_path "$HOME/bin"
    [ -r "$HOME/local/bin" ] && append_path "$HOME/local/bin"
    [ -r "$HOME/local/sbin" ] && append_path "$HOME/local/sbin"
	;;
	*) # catch-all
  ;;
esac


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

[ -e "$HOME/.local/bin" ] && append_path "$HOME/.local/bin"

# python3 env using pipx or python -m venv
#
# ?? TODO Use regex to cover all python2.x && python3.x versions
[ -e "$HOME/.local/share/python3.11/bin" ] && append_path "$HOME/.local/python3.11/bin"
[ -e "$HOME/.local/share/python3.12/bin" ] && append_path "$HOME/.local/python3.12/bin"
[ -e "$HOME/.local/share/python3.13/bin" ] && append_path "$HOME/.local/python3.13/bin"

# pulsar apm env
if [[ -d "/opt/Pulsar/resources/app/ppm/bin" ]]; then
  PATH="$PATH:/opt/Pulsar/resources/app/ppm/bin"
fi

# Android SDK env
[[ -d "/opt/android-sdk/build-tools/36" ]] && PATH=/opt/android-sdk/build-tools/36:$PATH
[[ -d "/opt/android-sdk/platform-tools" ]] && PATH=/opt/android-sdk/platform-tools:$PATH

#QT_LOGGING_RULES="kwin_*.debug=true"; export QT_LOGGING_RULES

# pkgconfig env
if [ -x "$(which pkg-config)" ]; then
  # FIXME(JEFF): Add path validation here before blindly adding these to the default search path...
  PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib32/pkgconfig:/usr/share/pkgconfig"
  if [ -n "$HOMEBREW_PREFIX" ]; then
    PKG_CONFIG_PATH="${HOMEBREW_PREFIX}/lib:$PKG_CONFIG_PATH"
  fi
fi

if [ -n "$PKG_CONFIG_PATH" ]; then
  export PKG_CONFIG_PATH
fi

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

# homebrew env
#
# IMPORTANT(jeff): It is important that we put the binaries from brew **last**
# in our PATH environment. Otherwise, you will start executing common utilities
# from the wrong system!
# TODO(JEFF): Relocate this to Linux specific init...
setup_homebrew_env_linux

# NodeJS env
exists_exe nodenv &>/dev/null &&
  setup_nodejs_env

# SSH env
# shellcheck disable=SC1091
[ -e "$HOME/.bash/ssh" ] && . "$HOME/.bash/ssh"

# vscode env
# shellcheck disable=SC1090
[ -n "$(command -v code)" ] && . "$(code --locate-shell-integration-path bash)"

# rust env
# 1. https://doc.rust-lang.org/cargo/commands/cargo-install.html#
if exists_exe cargo &>/dev/null; then
  #CARGO_HOME=$HOME/.cargo
  #CARGO_INSTALL_ROOT=$HOME/.cargo/bin
  mkdir -p "$HOME/.cargo/bin"

  CARGO_ENV_FILE="$HOME/.cargo/env"
  # shellcheck disable=SC1090
  [ -f "$CARGO_ENV_FILE" ] &&
    . "$CARGO_ENV_FILE"
  [ -d "$HOME/.cargo/bin" ] &&
    append_path "$HOME/.cargo/bin"
fi

[ -r "/scripts/bin" ] && PATH="/scripts/bin:$PATH"
