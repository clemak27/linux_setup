#!/bin/sh

status() {
  PAUSED=$(dunstctl is-paused)

  if [ "$PAUSED" = "false" ]; then
    echo "  "
  else
    echo "  "
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
  PAUSED=$(dunstctl is-paused)
  if [ "$PAUSED" = "false" ]; then
    # does not work
    dunstify -h string:x-dunst-stack-tag:notifications -i bell Notifications paused
  else
    dunstify -h string:x-dunst-stack-tag:notifications -i bell Notifications resumed
  fi
  dunstctl set-paused toggle
}

case "$1" in
  --toggle)
    toggle
    ;;
  *)
    listen
    ;;
esac
