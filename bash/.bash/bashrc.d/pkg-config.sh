# ~/.bash/bashrc.d/pkg-config.sh:jeff
#
# shellcheck shell=bash
#
# Additional pkg-config search paths
#
# SEE ALSO
# 1. pkg-config
#

[ -r "$HOME/.bash/lib" ] && . "$HOME/.bash/lib"

if exists_exe pkg-config &>/dev/null; then
  append_pkgconfig_path "/usr/local/lib/pkgconfig"
  append_pkgconfig_path "$HOME/local/lib/pkgconfig"
  append_pkgconfig_path "/usr/lib/pkgconfig"

  export PKG_CONFIG_PATH
fi

