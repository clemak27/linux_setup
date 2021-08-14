#!/bin/sh

tmux new-session -d -s root -n root
tmux set status off

tmux selectp -t root:1.1
tmux split-window -v
tmux resize-pane -t root:1.2 -y 16

tmux selectp -t root:1.1
tmux send-keys " unset TMUX; tmux new -s dev -n projects -c ~/Projects" C-m

tmux selectp -t root:1.2
tmux send-keys " unset TMUX; tmux new -s term -n projects -c ~/Projects" C-m

tmux attach-session -d
