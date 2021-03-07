#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

polybar_path="$HOME/Projects/linux_setup/polybar/config"

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=$polybar_path --reload topbar &
  done
else
  polybar --config=$polybar_path --reload topbar &
fi

# displays=$(xrandr -q | grep " connected" | cut -d ' ' -f1)
# exec echo $displays | grep -q "eDP1" &&
# exec polybar --reload eDP1 &

# exec echo $displays | grep -q "DP1" &&
# exec polybar --reload DP1 &
