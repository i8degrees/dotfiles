# ~/.bash/bashrc.d/fcitx5.sh:jeff
#
# shellcheck shell=bash
#
# Executed by bash(1) shell at
# the time of sourcing ~/.bashrc
#

# >> NOTE: After this script is installed, you must restart your Wayland env
# before this will take effect!

if [ -n "$DEBUG" ]; then
    echo "$0 - Initializing fcitx5 env."
    echo
fi

# fcitx5 env
#
# 1. https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland/en#KDE_Plasma
#
# ?? TODO(JEFF): use im-config?
if ! exists_exe fcitx5 &>/dev/null; then
  if [ -n "$DEBUG" ]; then
    echo "fcitx5 is not installed"
    echo
  fi

  return 1 # ENOENT; silent
fi

# shellcheck disable=SC2034
[ "$XDG_SESSION_TYPE" = "wayland" ] &&
  XMODIFIERS=@im=fcitx

if [ -n "$GTK_IM_MODULE" ]; then
  # ?? TODO(JEFF): [ -n "$DEBUG" ] &&
  echo "ERROR: GTK_IM_MODULE was already set -- unsetting this now."
  echo
  unset GTK_IM_MODULE
fi

if [ -n "$QT_IM_MODULE" ]; then
  # ?? TODO(JEFF): [ -n "$DEBUG" ] &&
  echo "ERROR: QT_IM_MODULE was already set -- unsetting this now."
  echo
  unset QT_IM_MODULE
fi

