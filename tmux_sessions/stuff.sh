#!/bin/sh

tmux new-session -d -n Stuff
tmux rename-window Stuff
tmux set status off

tmux split-window -h
tmux selectp -t 1
tmux send-keys "tty-clock -cs -C 4" C-m
tmux resize-pane -t 1 -L 5
tmux split-window -v
tmux resize-pane -t 1 -U 17
tmux selectp -t 2
tmux send-keys "btm" C-m

tmux selectp -t 3
tmux send-keys " notes"
tmux split-window -v
tmux selectp -t 4
tmux send-keys "clear_scrollback" C-m

tmux attach-session -d
