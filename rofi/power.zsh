#!/bin/zsh

if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
    echo -en "Reboot\0icon\x1fsystem-restart\n"
    # echo -en "Logout\0icon\x1fsystem-log-out\n"
    echo -en "Suspend\0icon\x1fsystem-suspend\n"
else
    if [ "$1" = "Shutdown" ]; then
        echo -en "Cancel\0icon\x1fgnome-panel-force-quit\n"
        echo -en "Confirm\0icon\x1fsystem-shutdown\n"
    elif [ "$1" = "Reboot" ]; then
        shutdown -r 0
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    elif [ "$1" = "Confirm" ]; then
      shutdown 0
    elif [ "$1" = "Cancel" ]; then
    fi
fi
