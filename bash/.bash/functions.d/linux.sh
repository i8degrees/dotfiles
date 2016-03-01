#!/bin/bash
#
# 2016-02/22:jeff
#
# User function helpers for Linux

function apkg()
{
  if [[ -z "$1" ]]; then
    echo "Usage: apkg <pkg> ... where <pkg> is the AUR package name"
  else
    command wget http://aur.archlinux.org/packages/"$1"/"$1".tar.gz
  fi
}

find_app 'geany' geany
find_app 'geany' geany
find_app 'scite' scite
find_app 'firefox' firefox
find_app 'meld' meld
find_app 'bless' bless
find_app 'gtkman' gtkman
find_app 'epdfview' epdfview
find_app 'ggv' ggv
find_app 'pkgbrowser' pkgbrowser
find_app 'luakit' luakit
find_app 'thunar' open

find_app 'gitg' gitg
find_app 'alsamixer' 'alsamixer -c0'
