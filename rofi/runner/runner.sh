#!/bin/zsh

rofi -combi-modi window,drun \
     -show combi \
     -modi combi,calc,'power:~/Projects/linux_setup/rofi/runner/power.sh' \
     -me-select-entry '' \
     -me-accept-entry 'MousePrimary' \
     -theme ./custom.rasi
