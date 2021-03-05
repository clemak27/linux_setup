#!/bin/sh

listen() {
  MUTED=$(pactl list sources | awk '/Mute:/ {print $2; exit}')

  if [ "$MUTED" = "yes" ]; then
    echo "muted"
  else
    echo "not muted"
  fi
}

toggle() {
  MUTED=$(pactl list sources | awk '/Mute:/ {print $2; exit}')
  DEFAULT_SOURCE=$(pactl info | awk '/Default Source:/ {print $3; exit}')

  if [ "$MUTED" = "yes" ]; then
    pactl set-source-mute "$DEFAULT_SOURCE" 1
  else
    pactl set-source-mute "$DEFAULT_SOURCE" 0
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
