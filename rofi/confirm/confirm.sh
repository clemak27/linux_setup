#!/usr/bin/env bash

rofi_path=$HOME/Projects/linux_setup/rofi

# options to be displayed
option0="     Confirm"
option1="🗙     Cancel"

# options passed into variable
options="$option0\n$option1"

chosen="$(echo -e "$options" | rofi -lines 2 -dmenu -selected-row 1 -theme $rofi_path/confirm/confirm.rasi)"
case $chosen in
    $option0)
        echo "yes";;
    $option1)
        echo "no";;
esac
