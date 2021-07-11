#!/bin/sh

tmux new-session -d -n root
tmux rename-window root
tmux set status off

tmux selectp -t 1
tmux split-window -v
tmux resize-pane -t 2 -y 16

tmux selectp -t 1
tmux send-keys " unset TMUX; tmux new -s dev -n projects -c ~/Projects" C-m

tmux selectp -t 2
tmux send-keys " unset TMUX; tmux new -s term -n projects -c ~/Projects" C-m

tmux attach-session -d
