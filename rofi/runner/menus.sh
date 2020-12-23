#!/usr/bin/env bash

rofi_path=$HOME/Projects/linux_setup/rofi

power="Powermenu"
network="Networkmenu"

options="$power\n$network"

if [ -z "$@" ]; then
  echo -e $options
else
  if [ "$1" = $power ]; then
    coproc $rofi_path/powermenu/powermenu.sh > /dev/null
    exit;
  elif [ "$1" = $network ]; then
    coproc $rofi_path/network/network.sh > /dev/null
    # elif [ "$1" = "Suspend" ]; then
    #   systemctl suspend
    # elif [ "$1" = "Confirm" ]; then
    #   shutdown 0
    # elif [ "$1" = "Cancel" ]; then
  fi
fi
