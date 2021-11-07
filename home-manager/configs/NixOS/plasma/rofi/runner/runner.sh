#!/bin/sh

rofi_path=$HOME/Projects/linux_setup/rofi

rofi -combi-modi window,drun \
     -show combi \
     -modi combi \
     -me-select-entry '' \
     -me-accept-entry 'MousePrimary' \
     -theme $rofi_path/runner/runner.rasi

# rofi -combi-modi window,drun \
#      -show combi \
#      -modi combi,calc,"menus:$rofi_path/runner/menus.sh" \
#      -me-select-entry '' \
#      -me-accept-entry 'MousePrimary' \
#      -theme $rofi_path/runner/runner.rasi
