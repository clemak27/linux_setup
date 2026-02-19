#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"

if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
  exit 0
fi

kwriteconfig6 --file "$config_dir/dolphinrc" --group "DetailsMode" --key "ExpandableFolders" "false"
kwriteconfig6 --file "$config_dir/dolphinrc" --group "DetailsMode" --key "PreviewSize" "32"
kwriteconfig6 --file "$config_dir/dolphinrc" --group "General" --key "ConfirmClosingMultipleTabs" "false"
kwriteconfig6 --file "$config_dir/dolphinrc" --group "General" --key "RememberOpenedTabs" "false"
kwriteconfig6 --file "$config_dir/dolphinrc" --group "General" --key "ShowZoomSlider" "false"
kwriteconfig6 --file "$config_dir/dolphinrc" --group "KFileDialog Settings" --key "Places Icons Auto-resize" "false"
kwriteconfig6 --file "$config_dir/dolphinrc" --group "KFileDialog Settings" --key "Places Icons Static Size" "22"

kwriteconfig6 --file "$config_dir/kcminputrc" --group "Mouse" --key "cursorTheme" "breeze_cursors"

kwriteconfig6 --file "$config_dir/kdeglobals" --group "General" --key "ColorScheme" "BlackBreeze"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "General" --key "AccentColor" "146,110,228"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "General" --key "accentColorFromWallpaper" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "Icons" --key "Theme" "Papirus-Dark"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KDE" --key "ShowDeleteCommand" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KDE" --key "widgetStyle" "Klassy"

kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Allow Expansion" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Automatically select filename extension" "true"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Breadcrumb Navigation" "true"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Decoration position" "2"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "LocationCombo Completionmode" "5"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "PathCombo Completionmode" "5"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Show Bookmarks" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Show Full Path" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Show Inline Previews" "true"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Show Preview" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Show Speedbar" "true"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Show hidden files" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Sort by" "Name"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Sort directories first" "true"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Sort hidden files last" "true"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Sort reversed" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "Speedbar Width" "140"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "KFileDialog Settings" --key "View Style" "Detail"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "PreviewSettings" --key "EnableRemoteFolderThumbnail" "false"
kwriteconfig6 --file "$config_dir/kdeglobals" --group "PreviewSettings" --key "MaximumRemoteSize" "0"

kwriteconfig6 --file "$config_dir/kiorc" --group "Confirmations" --key "ConfirmDelete" "true"
kwriteconfig6 --file "$config_dir/kiorc" --group "Confirmations" --key "ConfirmEmptyTrash" "true"
kwriteconfig6 --file "$config_dir/kiorc" --group "Confirmations" --key "ConfirmTrash" "false"
kwriteconfig6 --file "$config_dir/kiorc" --group "Executable scripts" --key "behaviourOnLaunch" "alwaysAsk"

kwriteconfig6 --file "$config_dir/klaunchrc" --group "BusyCursorSettings" --key "Bouncing" "false"
kwriteconfig6 --file "$config_dir/krunnerrc" --group "General" --key "FreeFloating" "true"
kwriteconfig6 --file "$config_dir/krunnerrc" --group "Plugins" --key "krunner_katesessionsEnabled" "false"
kwriteconfig6 --file "$config_dir/krunnerrc" --group "Plugins" --key "krunner_konsoleprofilesEnabled" "false"
kwriteconfig6 --file "$config_dir/krunnerrc" --group "Plugins/Favorites" --key "plugins" "krunner_services,krunner_systemsettings"
kwriteconfig6 --file "$config_dir/kscreenlockerrc" --group "Daemon" --key "Autolock" "false"
kwriteconfig6 --file "$config_dir/kscreenlockerrc" --group "Daemon" --key "Timeout" "0"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Effect-blur" --key "BlurStrength" "3"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Effect-blur" --key "NoiseStrength" "2"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Effect-overview" --key "BorderActivate" "9"
kwriteconfig6 --file "$config_dir/kwinrc" --group "NightColor" --key "Active" "true"
kwriteconfig6 --file "$config_dir/kwinrc" --group "NightColor" --key "NightTemperature" "4400"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "blurEnabled" "false"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "contrastEnabled" "false"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "glassEnabled" "true"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "kwin4_effect_geometry_changeEnabled" "true"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Xwayland" --key "Scale" "1"
kwriteconfig6 --file "$config_dir/kwinrc" --group "org.kde.kdecoration2" --key "ButtonsOnLeft" "X"
kwriteconfig6 --file "$config_dir/kwinrc" --group "org.kde.kdecoration2" --key "ButtonsOnRight" "F"
kwriteconfig6 --file "$config_dir/kwinrc" --group "org.kde.kdecoration2" --key "theme" "Klassy"
kwriteconfig6 --file "$config_dir/kwinrc" --group "org.kde.kdecoration2" --key "library" "org.kde.klassy"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Effect-blurplus" --key "BlurStrength" "6"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Effect-blurplus" --key "NoiseStrength" "3"
kwriteconfig6 --file "$config_dir/kwinrc" --group "Effect-blurplus" --key "WindowClasses" "org.wezfurlong.wezterm"
kwriteconfig6 --file "$config_dir/kxkbrc" --group "Layout" --key "Options" "caps:escape_shifted_capslock"

if [ "$HOSTNAME" != "fermi" ]; then
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "krohnkiteEnabled" "true"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "floatingTitle" "Picture-in-Picture"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "preventMinimize" "false"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "screenGapBetween" "9"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "screenGapBottom" "9"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "screenGapLeft" "9"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "screenGapRight" "9"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "screenGapTop" "9"
  if [ "$HOSTNAME" = "maxwell" ]; then
    kwriteconfig6 --file "$config_dir/kwinrc" --group "Script-krohnkite" --key "ignoreScreen" "DP-3"
  fi
else
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "krohnkiteEnabled" "false"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "karouselEnabled" "true"
fi

kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LANG" "en_GB.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_ADDRESS" "de_AT.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_MEASUREMENT" "de_AT.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_MONETARY" "de_AT.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_NAME" "de_AT.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_NUMERIC" "de_AT.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_PAPER" "de_AT.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_TELEPHONE" "de_AT.UTF-8"
kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_TIME" "de_AT.UTF-8"
