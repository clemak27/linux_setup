#!/bin/zsh

rofi -combi-modi window,drun \
     -show combi \
     -modi combi,calc,'power:~/Projects/linux_setup/rofi/power.zsh' \
     -me-select-entry '' \
     -me-accept-entry 'MousePrimary' \
     -theme ./custom.rasi
