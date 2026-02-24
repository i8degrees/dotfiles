#!/bin/sh
#
# ~/.tmux/ssh.tmux:jeff
#
# SSH environment
#
# IMPORTANT(JEFF): The shell snippet at `~/dotfiles.git/ssh-agent/.bash/ssh`
# must be installed with `stow` and then the following added to your
# `~/.profile`:
#
# `[ -e "$HOME/.bash/ssh" ] && . $HOME/.bash/ssh`
#
# This assumes that you have already installed the following packages onto your host:
#
# 1) stow;
# 2) tmux;
# 3) git clone of github.com:i8degrees/dotfiles.git
#

# TODO(JEFF): An attempt at helping the user; install our script if this is not already done --
# the idea here is the same as the TPM auto-installer inside of `.tmux.conf` so that we can simply
# get on with our lives after stowing the tmux package and its git module deps.
# if "test ! -e ~/.bash/ssh" \
  # "run 'cd ~/dotfiles.git && stow -R ssh-agent'"

tmux set -g update-environment "DISPLAY XAUTHORITY SSH_AUTH_LOCK SSH_ASKPASS WINDOWID SSH_CONNECTION SSH_AUTHORITY XDG_SESSION_TYPE"
tmux setenv -g SSH_AUTH_SOCK "$HOME/.ssh/ssh_agent"

