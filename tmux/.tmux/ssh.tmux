#!/usr/bin/env bash
# ~/.tmux/ssh.tmux:jeff
#
# SSH environment
#
# IMPORTANT(JEFF): The BASH snippet at `~/dotfiles.git/ssh-agent/.bash/ssh`
# must be installed -- `stow` -- and then the following added to your `~/.profile`:
#
# `[ -e "$HOME/.bash/ssh" ] && . $HOME/.bash/ssh`
#
# This assumes that you have already installed -- `stow` -- the `tmux` package
# from my dotfiles git repo.
#

tmux set -g update-environment "SSH_AUTH_LOCK SSH_ASKPASS WINDOWID SSH_CONNECTION SSH_AUTHORITY"
tmux setenv -g SSH_AUTH_SOCK "$HOME/.ssh/ssh_agent"

