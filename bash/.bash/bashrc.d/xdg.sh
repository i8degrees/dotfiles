# ~/.bash/bashrc.d/xdg.sh:jeff
#
# shellcheck shell=bash
#
# XDG_RUNTIME_DIR
#

# >> Our Alpine Linux distro does not set this for us
# >> because we setup this service as console only.
#
# >> Most distributions set this for us automatically
if [ -z "$XDG_RUNTIME_DIR" ]; then
  XDG_RUNTIME_DIR="/tmp/run/user/$(id -u)"; export XDG_RUNTIME_DIR
fi

