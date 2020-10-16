#!/bin/zsh

rofi -combi-modi window,drun \
     -show combi \
     -modi combi,'Powermenu:~/Projects/linux_setup/rofi/powermenuMode.sh' \
     -me-select-entry '' \
     -me-accept-entry 'MousePrimary' \
     -theme custom
