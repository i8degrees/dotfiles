#!/bin/bash
#
# 2016-02/14:jeff
#
# Platform-specific configuration for Linux hosts
#
# NOTE(jeff): This file is sourced from bash_profile

export PATH="$HOME/local/bin:$PATH"
TMPDIR="/tmp"; export TMPDIR

PATH="$PATH:$HOME/.config/feh/themes"; export PATH

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

if [[ -r "/etc/bash_completion" ]]; then
  source /etc/bash_completion
fi

#SSH_ASKPASS=""; export SSH_ASKPASS
#SUDO_ASKPASS=""; export SUDO_ASKPASS
