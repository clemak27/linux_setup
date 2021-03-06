#!/bin/sh

status() {
  # the output contains monitor and sources, so i check if any of them is muted
  MUTED=$(pactl list sources | awk '/Mute:/ {print $2}' | awk '/yes/ {print $0;exit}')

  if [ "$MUTED" = "yes" ]; then
    echo " "
  else
    echo " "
  fi
}

listen() {
  while :
  do
    sleep 1
    status
  done
}

toggle() {
  MUTED=$(pactl list sources | awk '/Mute:/ {print $2}' | awk '/yes/ {print $0;exit}')
  DEFAULT_SOURCE=$(pactl info | awk '/Default Source:/ {print $3; exit}')

  if [ "$MUTED" = "yes" ]; then
    pactl set-source-mute "$DEFAULT_SOURCE" 0
  else
    pactl set-source-mute "$DEFAULT_SOURCE" 1
  fi
}

case "$1" in
  --toggle)
    toggle
    ;;
  *)
    listen
    ;;
esac
