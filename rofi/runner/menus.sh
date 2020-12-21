#!/usr/bin/env bash

rofi_path=$HOME/Projects/linux_setup/rofi

if [ -z "$@" ]; then
  echo -en "Powermenu\n"
else
  if [ "$1" = "Powermenu" ]; then
  coproc $rofi_path/powermenu/powermenu.sh > /dev/null
  exit;
  # elif [ "$1" = "Reboot" ]; then
  #   shutdown -r 0
  # elif [ "$1" = "Suspend" ]; then
  #   systemctl suspend
  # elif [ "$1" = "Confirm" ]; then
  #   shutdown 0
  # elif [ "$1" = "Cancel" ]; then
  fi
fi
