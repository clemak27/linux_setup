#!/bin/bash

set -eo pipefail

if [ "$XDG_CURRENT_DESKTOP" != "niri" ]; then
  exit 0
fi

dconf write /org/gnome/desktop/interface/accent-color '"slate"'
dconf write /org/gnome/desktop/wm/preferences/button-layout '":close"'
dconf write /org/gnome/nautilus/list-view/use-tree-view false
dconf write /org/gnome/nautilus/preferences/default-folder-viewer '"list-view"'
dconf write /org/gnome/nautilus/preferences/default-sort-order '"name"'
dconf write /org/gnome/nautilus/preferences/show-hidden-files true
dconf write /org/gtk/Settings/FileChooser/date-format '"regular"'
dconf write /org/gtk/Settings/FileChooser/location-mode '"path-bar"'
dconf write /org/gtk/Settings/FileChooser/show-hidden false
dconf write /org/gtk/Settings/FileChooser/show-size-column true
dconf write /org/gtk/Settings/FileChooser/show-type-column true
dconf write /org/gtk/Settings/FileChooser/sort-column '"name"'
dconf write /org/gtk/Settings/FileChooser/sort-directories-first true
dconf write /org/gtk/Settings/FileChooser/sort-order '"ascending"'
dconf write /org/gtk/Settings/FileChooser/type-format '"category"'

dms plugins install Calculator &> /dev/null || :
dms plugins install dankBatteryAlerts &> /dev/null || :
dms plugins install dankKDEConnect &> /dev/null || :
