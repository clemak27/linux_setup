#!/bin/bash

set -eo pipefail

dms_config="$HOME/.config/DankMaterialShell/settings.json"

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

if [ -f "$dms_config" ]; then
  yq -iP '.blurWallpaperOnOverview = false' "$dms_config" -o json
  yq -iP '.blurredWallpaperLayer = true' "$dms_config" -o json
  yq -iP '.centeringMode = "geometric"' "$dms_config" -o json
  yq -iP '.clockDateFormat = "dd.MM.yyyy"' "$dms_config" -o json
  yq -iP '.cornerRadius = 7' "$dms_config" -o json
  yq -iP '.currentThemeCategory = "dynamic"' "$dms_config" -o json
  yq -iP '.currentThemeName = "dynamic"' "$dms_config" -o json
  yq -iP '.cursorSettings.theme = "breeze_cursors"' "$dms_config" -o json
  yq -iP '.dankLauncherV2BorderColor = "primary"' "$dms_config" -o json
  yq -iP '.dankLauncherV2BorderEnabled = true' "$dms_config" -o json
  yq -iP '.dankLauncherV2BorderThickness = 2' "$dms_config" -o json
  yq -iP '.fontFamily = "Noto Sans"' "$dms_config" -o json
  yq -iP '.iconTheme = "Papirus-Dark"' "$dms_config" -o json
  yq -iP '.lockBeforeSuspend = true' "$dms_config" -o json
  yq -iP '.lockScreenPowerOffMonitorsOnLock = true' "$dms_config" -o json
  yq -iP '.matugenScheme = "scheme-content"' "$dms_config" -o json
  yq -iP '.matugenTemplateNeovim = false' "$dms_config" -o json
  yq -iP '.monoFontFamily = "JetBrainsMonoNL Nerd Font"' "$dms_config" -o json
  yq -iP '.niriLayoutGapsOverride = 10' "$dms_config" -o json
  yq -iP '.niriLayoutRadiusOverride = 7' "$dms_config" -o json
  yq -iP '.osdAlwaysShowValue = true' "$dms_config" -o json
  yq -iP '.osdPosition = 7' "$dms_config" -o json
  yq -iP '.useAutoLocation = true' "$dms_config" -o json
  yq -iP '.widgetBackgroundColor = "s"' "$dms_config" -o json

fi

dms plugins install Calculator &> /dev/null || :
dms plugins install dankBatteryAlerts &> /dev/null || :
dms plugins install dankKDEConnect &> /dev/null || :
