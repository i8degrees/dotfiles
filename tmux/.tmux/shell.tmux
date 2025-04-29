#!/usr/bin/env bash
# ~/.tmux/shell.tmux:jeff
#
# Shell environment setup
#
#
# SEE ALSO
#
# 1. $HOME/.tmux.conf
# 1. $HOME/.tmux/shell.tmux
#

if [[ "$OSTYPE" =~ 'linux-android' ]]; then
  if [[ -n "$DEBUG" ]] && [[ -z "$TBIN" ]]; then
    echo "ERROR: OS detection yields linux-android, but"
    echo "why is the TBIN env not setup?"
    echo
    #return 1
  fi

  # /bin/sh
  #shell_env=$SHELL
  shell_env="$TBIN/bash"
  if [ ! -x "$shell_env" ]; then
    # TODO(JEFF): Consider using and verifying whether or not
    # the which check returns truthy in addition to the TBIN
    # env check.
    #shell_env="$(which "$shell_env")"
    shell_env="$TBIN/bash"
  fi

  tmux set -g default-shell "$shell_env"
  tmux set -g default-command "$shell_env -l"
elif [[ "$OSTYPE" =~ 'linux' ]]; then
  shell_env=$SHELL
  tmux set -g default-shell "$shell_env"
  tmux set -g default-command "$shell_env -l"
elif [[ "$OSTYPE" =~ 'darwin' ]]; then
  shell_env=$SHELL

  # NOTE(JEFF): I believe that the tmux plugin
  # [tmux-plugins/tmux-sensible][10] takes care of the following for
  # us. Thus, the set can be removed once we verify this
  # when inside of MacOS.
  #
  # [10]: https://github.com/tmux-plugins/tmux-sensible

  # Fix pbcopy/pbpaste for old tmux versions (pre tmux v2.6)
  tmux set -g default-command "reattach-to-user-namespace -l $shell_env"
fi

# NOTE(JEFF): Reserved for future implementation
if [[ "$OSTYPE" =~ 'windows' ]]; then
  # TODO(JEFF): Implement handling for `windows` env
  true
elif [[ "$OSTYPE" =~ 'msys' ]]; then
  # TODO(JEFF): Implement handling for `msys` env
  true
fi

# NOTE(JEFF): ...Handle terminal capabilities here...

# IMPORTANT(JEFF): We must choose a sane default for terminal capabilities; since we deal with so many
# different platforms, "xterm-256color" is the only failsafe option for us!
tmux set -g default-terminal "xterm-256color"

# IMPORTANT(JEFF): Ensure that our terminals we use have support for clipboard
#
# TODO(JEFF): Add urxvt-unicode TERM here?
tmux set -as terminal-features ',screen-256color*:clipboard'
tmux set -as terminal-features ',xterm-256color*:clipboard'
tmux set -as terminal-features ',tmux-256color*:clipboard'

