#!/usr/bin/env bash

# options to be displayed
option0="yes"
option1="no"

# options passed into variable
options="$option0\n$option1"

chosen="$(echo -e "$options" | rofi -lines 2 -dmenu -p "Are you sure?" -selected-row 1 -theme ./confirm.rasi)"
case $chosen in
    $option0)
        echo "yes";;
    $option1)
        echo "no";;
esac
