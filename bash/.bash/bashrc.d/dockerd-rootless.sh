# ~/.bash/bashrc.d/dockerd-rootless.sh:jeff
#
# shellcheck shell=bash
#
# Docker rootless install
#
# SEE ALSO
# 1. man dockerd
#

USERID="$(id -u)"
# >> We prefer the usage of `docker context use` over the
# >> user environment being modified.
USE_DOCKER_CONTEXT=1

if [ -z "$USE_DOCKER_CONTEXT" ]; then
  if exists_exe dockerd &>/dev/null; then
    export DOCKER_HOST="/run/user/$USERID/docker.sock"
  fi
fi

append_path "$HOME/bin"

