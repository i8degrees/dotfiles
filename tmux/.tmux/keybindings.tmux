#!/usr/bin/env bash
# ~/.tmux/keybindings.tmux:jeff
#
# tmux key bindings setup
#
#
# SEE ALSO
#
# 1. $HOME/.tmux.conf
#
# TODO(JEFF): Use the tmux command display-message as indicators on our binded key
#	actions. Example: tmux bind F5 \; run 'display-message "Reloading local config"' \;
#	...and so forth.

# new prefix key; ^X
tmux unbind C-b
tmux set -g prefix C-x

tmux unbind x
tmux bind x send-prefix

# Always create a new window from the current working path inside the active tmux pane
#
# https://github.com/tmux/tmux/wiki/Recipes#create-new-panes-in-the-same-working-directory
tmux unbind n
tmux bind n new-window -c "#{pane_current_path}"

# FIXME(JEFF): Re-enable once we have everything else working!
#
# Create a new pane to copy; opens a new pane with the history of the active pane --
# useful to copy multiple items from the history to the shell prompt.
#
# https://github.com/tmux/tmux/wiki/Recipes#create-a-new-pane-to-copy
#tmux unbind C
#tmux bind C {
#	splitw -f -l30% ''
#	set-hook -p pane-mode-changed 'if -F "#{!=:#{pane_mode},copy-mode}" "kill-pane"'
#	copy-mode -s'{last}'
#}

tmux unbind l
tmux bind l previous-window

tmux bind tab next-window

# Always split a window from the current working path inside the active tmux pane
#
# https://github.com/tmux/tmux/wiki/Recipes#create-new-panes-in-the-same-working-directory
tmux unbind |
tmux bind | tmux split-window -hc "#{pane_current_path}"

tmux unbind -
tmux bind - tmux split-window -vc "#{pane_current_path}"

# NOTE(JEFF): Reload the user's tmux configuration file;
# this assumes that the file is always at "$HOME/.tmux.conf".
# ^-F5
tmux unbind F5
tmux bind F5 run 'tmux display-message "Reloading your tmux configuration..."'\; tmux source-file "$HOME/.tmux.conf"\; run "tmux refresh-client"\;

# toggle recording the output of the current pane
#
# TODO(JEFF): We need a notification upon toggle of this feature; one of the topics in the tmux
# wiki shares with us a recipe that should aid in this addition.
tmux bind P pipe-pane -o 'cat >~/.tmux/sessions/#{session_id}_#{window_id}_#{pane_id}.log'

tmux unbind u
tmux bind u run-shell "$HOME/.tmux/plugins/tpm/bin/install_plugins"

tmux bind enter command-prompt -p ":" %1

# ^ CTRL+w
tmux bind C-w command-prompt -p "(rename-window)" "rename-window %1"

# tmux unbind r
# tmux bind r command-prompt -p "(rename-session)" "rename-session %1"

# ^ CTRL+b
tmux bind C-b confirm-before -p "kill-session #S? (y/n)" kill-session

tmux unbind &
tmux bind & confirm-before -p "kill-window #W? (y/n)" kill-window

# ^ CTRL+x
tmux unbind C-x
tmux bind C-x confirm-before -p "kill-pane #P? (y/n)" kill-pane

# key bindings when the tmux opt "mode-keys" is set to emacs
# ^ CTRL+c
tmux bind -Tcopy-mode C-c               send -X copy-pipe-and-cancel 'xsel -i -b'
# ???
tmux bind -Tcopy-mode M-w               send -X copy-pipe-and-cancel 'xsel -i -b'
tmux bind -Tcopy-mode MouseDragEnd1Pane send -X copy-pipe-and-cancel 'xsel -i -b'

# key bindings when the tmux opt "mode-keys" is set to vi
# ^ CTRL+j
# tmux bind -Tcopy-mode-vi C-j               send -X copy-pipe-and-cancel 'xsel -i -b'
# tmux bind -Tcopy-mode-vi Enter             send -X copy-pipe-and-cancel 'xsel -i -b'
# tmux bind -Tcopy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel 'xsel -i -b'

# key bindings when the tmux opt "mode-keys" is set to vi
tmux bind -Tcopy-mode-vi 'v'           send -X begin-selection
tmux bind -Tcopy-mode-vi 'y'           send -X copy-pipe-and-cancel 'xsel -i -b'

# These bindings are for X Windows only. If you're using a different
# window system you have to replace the `xsel` commands with something
# else. See https://github.com/tmux/tmux/wiki/Clipboard#available-tools
# [SOURCE](https://www.seanh.cc/2020/12/27/copy-and-paste-in-tmux/)
tmux bind -Tcopy-mode          DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i -b"
tmux bind -Tcopy-mode-vi       DoubleClick1Pane select-pane \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i -b"
tmux bind -n DoubleClick1Pane  select-pane \; copy-mode -M \; send -X select-word \; send -X copy-pipe-no-clear "xsel -i -b"
tmux bind -Tcopy-mode          TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i -b"
tmux bind -Tcopy-mode-vi       TripleClick1Pane select-pane \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i -b"
tmux bind -n TripleClick1Pane  select-pane \; copy-mode -M \; send -X select-line \; send -X copy-pipe-no-clear "xsel -i -b"
tmux bind -n MouseDown2Pane    run "tmux set-buffer -b primary_selection \"$(xsel -b -o)\"; tmux paste-buffer -b primary_selection; tmux delete-buffer -b primary_selection"

# tmux unbind M-w
# tmux bind M-w command-prompt -I "(move-window -s source-window),(move-window -t target-window)" "move-window -s %1 -t %2"

tmux unbind v
tmux bind v run "tmux set-buffer \"$(xsel --clipboard --output)\"; tmux paste-buffer"

#tmux unbind u
# tmux bind u capture-pane \; run "tmux paste-buffer | urlview"

tmux unbind k
tmux bind k run "tmux clear-history"

# IMPORTANT(jeff): Unbind the list of key bindings so that it prevents me
# from fat fingering the wrong key and seeing everything go up in smoke! ^_^
#
# 1. https://gist.githubusercontent.com/mzmonsour/8791835/raw/0a9f8ed7c3bfafba153117ad317284cf4bae4678/tmux-default-bindings.txt

tmux unbind q

# tmux bind q kill-pane
tmux unbind d

# Detach tagged clients
tmux unbind D

# Detach and HUP selected clients
# tmux unbind x

# detach and HUP tagged clients
tmux unbind X

# suspend selected clients
tmux unbind z

# suspend tagged clients
tmux unbind Z

tmux unbind %
tmux unbind '"'

# tmux command prompt
tmux unbind :

# default rename-session key
tmux unbind $
tmux unbind ,
