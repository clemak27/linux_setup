#!/bin/sh

tmux new-session -d -s stuff -n stuff
tmux set status off

tmux split-window -h
tmux select-pane -t stuff:1.1
tmux send-keys "tty-clock -cs -C 4" C-m
tmux resize-pane -t stuff:1.1 -L 5
tmux split-window -v
tmux resize-pane -t stuff:1.1 -U 17
tmux selectp -t stuff:1.2
tmux send-keys "btm" C-m

tmux selectp -t stuff:1.3
tmux send-keys " notes"
tmux split-window -v
tmux selectp -t stuff:1.4
tmux send-keys "clear_scrollback" C-m

tmux attach-session -d -t stuff
