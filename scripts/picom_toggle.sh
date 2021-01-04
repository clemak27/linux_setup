#!/bin/sh

pidof picom  >/dev/null

if [[ $? -ne 0 ]] ; then
  picom -b
else
  killall -15 picom
fi
