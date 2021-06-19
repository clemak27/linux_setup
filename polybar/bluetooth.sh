#!/bin/sh

watch() {
  if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
  then
    echo "%{F#66ffffff}"
  else
    if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
    then
      echo ""
    fi
    echo "%{F#0094f9}"
  fi
}

toggle() {
  if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
  then
    bluetoothctl power on
  else
    bluetoothctl power off
  fi
}

case "$1" in
  --toggle)
    toggle
    ;;
  *)
    watch
    ;;
esac
