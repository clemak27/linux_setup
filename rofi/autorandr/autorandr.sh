#!/usr/bin/env bash

rofi_path=$HOME/Projects/linux_setup/rofi

rofi_command="rofi -theme $rofi_path/autorandr/autorandr.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Variable passed to rofi
options=$(autorandr)

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
  *)
    autorandr $(echo $chosen | awk '{print $1}')
    ;;
esac
