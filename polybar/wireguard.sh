#!/bin/sh

status() {
  WG_CONF_NAME=$(cat /etc/hostname)
  CONNECTED=$(ip addr show $WG_CONF_NAME | awk "/$WG_CONF_NAME:/ {print $2}" | awk "/$WG_CONF_NAME/ {print \"true\";exit}")

  if [ "$CONNECTED" = "true" ]; then
    echo " "
  else
    echo " "
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
  WG_CONF_NAME=$(cat /etc/hostname)
  CONNECTED=$(ip addr show $WG_CONF_NAME | awk "/$WG_CONF_NAME:/ {print $2}" | awk "/$WG_CONF_NAME/ {print \"true\";exit}")

  if [ "$CONNECTED" = "true" ]; then
    alacritty --title=wg-quick-pb --option=window.dimensions.columns=80 --option=window.dimensions.rows=40 --command wg-quick down $WG_CONF_NAME
  else
    alacritty --title=wg-quick-pb --option=window.dimensions.columns=80 --option=window.dimensions.rows=40 --command wg-quick up $WG_CONF_NAME
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
