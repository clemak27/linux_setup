#!/bin/zsh

if [ -z "$@" ]; then
    echo -en "Shutdown\n"
    echo -en "Suspend\n"
    echo -en "Reboot\n"
    echo -en "Cancel\n"
else
    if [ "$1" = "Shutdown" ]; then
        echo -en "Now\n30s\n1m"
    elif [ "$1" = "Reboot" ]; then
        shutdown -r 0
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    elif [ "$1" = "Now" ]; then
      shutdown 0
    elif [ "$1" = "30s" ]; then
      shutdown 30
    elif [ "$1" = "1m" ]; then
      shutdown 60
    fi
fi
