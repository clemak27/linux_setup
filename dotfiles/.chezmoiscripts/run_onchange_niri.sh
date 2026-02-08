#!/bin/bash

set -eo pipefail

dms_config="$HOME/.config/DankMaterialShell/settings.json"

if [ "$XDG_CURRENT_DESKTOP" != "niri" ]; then
  exit 0
fi

gsettings set org.gnome.desktop.wm.preferences button-layout ':close'
gsettings set org.gnome.nautilus.list-view use-tree-view false
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences default-sort-order 'name'
gsettings set org.gnome.nautilus.preferences show-hidden-files true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

if [ -f "$dms_config" ]; then
  yq -iP '.widgetBackgroundColor = "s"' "$dms_config" -o json
  yq -iP '.niriLayoutGapsOverride = 10' "$dms_config" -o json
  yq -iP '.cursorSettings.theme = "breeze_cursors"' "$dms_config" -o json
  yq -iP '.iconTheme = "Papirus-Dark"' "$dms_config" -o json
  yq -iP '.fontFamily = "Noto Sans"' "$dms_config" -o json
  yq -iP '.monoFontFamily = "JetBrainsMonoNL Nerd Font"' "$dms_config" -o json
  yq -iP '.clockDateFormat = "dd.MM.yyyy"' "$dms_config" -o json
  yq -iP '.useAutoLocation = true' "$dms_config" -o json
  yq -iP '.centeringMode = "geometric"' "$dms_config" -o json
  yq -iP '.osdPosition = 7' "$dms_config" -o json
  yq -iP '.osdAlwaysShowValue = true' "$dms_config" -o json
  yq -iP '.lockBeforeSuspend = true' "$dms_config" -o json
fi
