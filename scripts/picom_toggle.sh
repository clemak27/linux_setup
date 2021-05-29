#!/bin/sh

pidof picom  >/dev/null

if [[ $? -ne 0 ]] ; then
  picom -b
  dunstify -h string:x-dunst-stack-tag:picom -i gtk-dialog-info picom "enabled"
else
  killall -15 picom
  dunstify -h string:x-dunst-stack-tag:picom -i gtk-dialog-info picom "disabled"
fi
