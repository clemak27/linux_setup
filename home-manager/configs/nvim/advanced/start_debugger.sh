#!/bin/sh

command="$*"


if tmux has-session -t term:debug > /dev/null; then
  tmux send-keys -t term:debug.1 "$command" Enter;
else
  tmux new-window -t term -n debug
  tmux send-keys -t term:debug.1 "$command" Enter;
fi
