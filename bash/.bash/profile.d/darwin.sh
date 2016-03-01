#!/bin/bash
#
# 2016-02/14:jeff
#
# Platform-specific configuration for Darwin hosts
#
# NOTE(jeff): This file is sourced from bash_profile

if [[ -x "$(which brew)" ]]; then
  LOCAL_SITE_PREFIX=$(brew --prefix)
fi

# MacTex-basic package (used with pdfjam from brew)
# PATH="$PATH:/usr/local/texlive/2013basic/bin/x86_64-darwin"

TMPDIR="/private/tmp"; export TMPDIR

# Use coreutils (brew package) commands with their normal names, AKA without
# the default 'g' prefix. This means using GNU's tools instead of the
# default provided BSD (OS X) tools.
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Access coreutils (brew package) man pages with their normal names
# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# gnu-sed brew package
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
export PATH

# homebrew/bash-completion
# Third-party user-land app completions for BASH
if [[ -f "${LOCAL_SITE_PREFIX}/etc/bash_completion" ]]; then
  source "${LOCAL_SITE_PREFIX}/etc/bash_completion"
fi

# homebrew/bash-completion2
# if [[ -f "${LOCAL_SITE_PREFIX}/share/bash-completion/bash_completion" ]]; then
  # . "${LOCAL_SITE_PREFIX}/share/bash-completion/bash_completion"
# fi

#SSH_ASKPASS="/usr/local/libexec/ssh-askpass"; export SSH_ASKPASS
#SUDO_ASKPASS="/usr/local/libexec/ssh-askpass"; export SUDO_ASKPASS

GIT_ASKPASS=/usr/local/bin/git-credential-osxkeychain; export GIT_ASKPASS

# CCACHE_PATH="/usr/local/opt/ccache/libexec"; export CCACHE_PATH
# CCACHE_DIR="/ramdisk/dir"; export CCACHE_DIR
# PATH="$CCACHE_PATH:$PATH"; export PATH

# Source: http://crossgcc.rts-software.org/doku.php?id=start
# PATH="/usr/local/gcc-4.8.0-qt-4.8.4-for-mingw32/win32-gcc/bin:${PATH}"
# PATH="${HOME}/local/opt/bin:${PATH}"; export PATH

# Additional pkg-config paths
OSX_PRODUCT_VERSION=$(sw_vers -productVersion)
PKG_CONFIG_PATH="/opt/X11/lib/pkgconfig"
PKG_CONFIG_PATH+="/usr/local/lib/pkgconfig"
PKG_CONFIG_PATH+="/usr/local/share/pkgconfig"
PKG_CONFIG_PATH+="/usr/lib/pkgconfig"
PKG_CONFIG_PATH+="/usr/local/Library/ENV/pkgconfig/${OSX_PRODUCT_VERSION}"
PKG_CONFIG_PATH+="/usr/local/opt/qt/lib/pkgconfig" # qt4-dev
PKG_CONFIG_PATH+="/usr/local/opt/qt5/lib/pkgconfig"
export PKG_CONFIG_PATH

# Setup the installation prefix path for global node.JS modules,
# i.e.: npm install <pkg> -g
NODE_PATH="/usr/local/lib/node_modules"; export NODE_PATH

# Setup the installation prefix path for Python modules
PYTHONPATH="${LOCAL_SITE_PREFIX}/lib/python2.7/site-packages"
export PYTHONPATH

# Add LLVM clang static-analysis module; installed via llvm Homebrew
# formula
STATIC_CPP_ANALYZER="/usr/local/opt/llvm/share/clang/tools/scan-build"
if [[ -x "${STATIC_CPP_ANALYZER}" ]]; then
  PATH="$STATIC_CPP_ANALYZER:${PATH}"; export PATH
fi

HOST_CONFIG="${HOME}/.bash/profile.d/${NOM_HOST}.sh"
if [[ -f "${HOST_CONFIG}" ]]; then
  # shellcheck disable=SC1090
  source "${HOST_CONFIG}"
fi

# Optional integration of our UNIX shell command history, current working
# directory and more for iTerm 2.9.x
#
# See also: https://iterm2.com/shell_integration.html
ITERM_SHELL_INTEGRATION_SH=${HOME}/.iterm2_shell_integration.bash
if [[ -x "/Applications/iTerm.app/Contents/MacOS/iTerm" ||
      -x "${HOME}/Applications/iTerm.app/Contents/MacOS/iTerm" ]]; then
  # shellcheck source=/Users/jeff/.iterm2_shell_integration.bash
  source "${ITERM_SHELL_INTEGRATION_SH}"
fi
