#!/bin/bash

# layout
# --------------------------
# |     |                  |
# |  1  |    2 (vim .)     |
# |     |                  |
# -------------------------|
# |           3            |
# --------------------------

# pane 3
tmux split-window -v -c '#{pane_current_path}'
tmux resize-pane -D 15

# pane 2
tmux select-pane -U
tmux split-window -h -c '#{pane_current_path}'
tmux resize-pane -L 60
tmux send-keys 'vim .'
tmux send-keys 'Enter'
tmux send-keys ',t'  # open nerdtree

# pane 1
tmux select-pane -L
tmux send-keys C-e C-u
tmux send-keys -R
tmux clear-history
sleep 1
tmux send-keys 'python'
tmux send-keys 'Enter'
