#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

__kde_applications() {
  rpm-ostree install --idempotent kontact
  flatpak install -y flathub \
    com.calibre_ebook.calibre \
    com.obsproject.Studio \
    hu.irl.cameractrls \
    org.gimp.GIMP \
    org.gimp.GIMP.HEIC \
    org.gimp.GIMP.Plugin.GMic//3 \
    org.kde.haruna \
    org.kde.kid3 \
    org.libreoffice.LibreOffice \
    org.signal.Signal
}

__kde_feishin() {
  feishin_version=0.12.3

  mkdir -p "$bin_dir" "$HOME/.local/share/applications"
  curl -L --url https://github.com/jeffvli/feishin/releases/download/v${feishin_version}/Feishin-${feishin_version}-linux-x86_64.AppImage -o "$bin_dir/feishin"
  chmod +x "$bin_dir/feishin"
  curl -L --url https://raw.githubusercontent.com/jeffvli/feishin/refs/heads/development/assets/icons/128x128.png -o "$HOME/.local/share/applications/feishin.png"
  echo -e "[Desktop Entry]\nName=Feishin\nExec=$HOME/.local/bin/feishin\nType=Application\nCategories=Multimedia\nIcon=$HOME/.local/share/applications/feishin.png" > "$HOME/.local/share/applications/feishin.desktop"
}

__kde_ksshaskpass() {
  rpm-ostree install --idempotent ksshaskpass
  mkdir -p "$HOME/.config/autostart"
  cat << EOF > "$HOME/.config/autostart/kssaskpass.sh.desktop"
[Desktop Entry]
Exec=$HOME/Projects/linux_setup/modules/kde/kssaskpass.sh
Icon=application-x-shellscript
Name=kssaskpass.sh
Type=Application
X-KDE-AutostartScript=true
EOF
}

__kde_colorscheme() {
  mkdir -p "$HOME/.local/share/color-schemes"
  ln -sf "$module_dir/BlackBreeze.colors" "$HOME/.local/share/color-schemes/BlackBreeze.colors"
}

__kde_konsole() {
  mkdir -p "$HOME/.local/share/konsole"
  ln -sf "$module_dir/MochaMatte.colorscheme" "$HOME/.local/share/konsole"
}

__kde_config() {
  kwriteconfig6 --file "$config_dir/dolphinrc" --group "DetailsMode" --key "ExpandableFolders" "false"
  kwriteconfig6 --file "$config_dir/dolphinrc" --group "DetailsMode" --key "PreviewSize" "32"
  kwriteconfig6 --file "$config_dir/dolphinrc" --group "General" --key "ConfirmClosingMultipleTabs" "false"
  kwriteconfig6 --file "$config_dir/dolphinrc" --group "General" --key "RememberOpenedTabs" "false"
  kwriteconfig6 --file "$config_dir/dolphinrc" --group "General" --key "ShowZoomSlider" "false"
  kwriteconfig6 --file "$config_dir/dolphinrc" --group "KFileDialog Settings" --key "Places Icons Auto-resize" "false"
  kwriteconfig6 --file "$config_dir/dolphinrc" --group "KFileDialog Settings" --key "Places Icons Static Size" "22"

  kwriteconfig6 --file "$config_dir/kcminputrc" --group "Mouse" --key "cursorTheme" "breeze_cursors"

  kwriteconfig6 --file "$config_dir/kdeglobals" --group "General" --key "ColorScheme" "BlackBreeze"
  kwriteconfig6 --file "$config_dir/kdeglobals" --group "General" --key "accentColorFromWallpaper" "true"
  kwriteconfig6 --file "$config_dir/kdeglobals" --group "Icons" --key "Theme" "Papirus-Dark"
  kwriteconfig6 --file "$config_dir/kdeglobals" --group "KDE" --key "ShowDeleteCommand" "false"
  kwriteconfig6 --file "$config_dir/kdeglobals" --group "KDE" --key "widgetStyle" "Breeze"

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
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Effect-overview" --key "BorderActivate" "9"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "NightColor" --key "Active" "true"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "NightColor" --key "NightTemperature" "4400"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "blurEnabled" "false"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Plugins" --key "contrastEnabled" "false"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "Xwayland" --key "Scale" "1"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "org.kde.kdecoration2" --key "theme" "Breeze"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "org.kde.kdecoration2" --key "ButtonsOnLeft" "X"
  kwriteconfig6 --file "$config_dir/kwinrc" --group "org.kde.kdecoration2" --key "ButtonsOnRight" "F"

  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LANG" "en_GB.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_ADDRESS" "de_AT.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_MEASUREMENT" "de_AT.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_MONETARY" "de_AT.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_NAME" "de_AT.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_NUMERIC" "de_AT.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_PAPER" "de_AT.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_TELEPHONE" "de_AT.UTF-8"
  kwriteconfig6 --file "$config_dir/plasma-localerc" --group "Formats" --key "LC_TIME" "de_AT.UTF-8"

  cp "$module_dir/kglobalshortcutsrc" "$config_dir/kglobalshortcutsrc"
  cp "$module_dir/kwinrulesrc" "$config_dir/kwinrulesrc"
}

###

__kde_jbm() {
  jbmono_version=3.2.1

  mkdir -p tmp "$HOME/.local/share/fonts"
  curl -Lo tmp/jbMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v${jbmono_version}/JetBrainsMono.zip"
  unzip -o tmp/jbMono.zip -d "$HOME/.local/share/fonts"
  cd "$HOME/.local/share/fonts" || exit 1
  find JetBrainsMonoNerdFontPropo* | xargs rm -f
  find JetBrainsMonoNerdFontMono* | xargs rm -f
  find JetBrainsMonoNL* | xargs rm -f
  rm OFL.txt && rm README.md
  cd "$module_dir" || exit 1
}

__kde_papirus() {
  wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.local/share/icons" sh
}

__kde_adw_gtk() {
  adw_gtk3_version=5.6

  mkdir -p tmp "$HOME/.local/share/themes" "$config_dir/gtk-3.0" "$config_dir/gtk-4.0"
  curl -Lo tmp/adw-gtk3.tar.xz --url https://github.com/lassekongo83/adw-gtk3/releases/download/v${adw_gtk3_version}/adw-gtk3v${adw_gtk3_version}.tar.xz
  tar xf tmp/adw-gtk3.tar.xz --directory "$HOME/.local/share/themes"
  flatpak install flathub -y org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
  flatpak override --user --filesystem=xdg-config/gtk-3.0 --filesystem=xdg-config/gtk-4.0
}

__kde_applications
__kde_feishin
__kde_ksshaskpass
__kde_colorscheme
__kde_konsole
__kde_config
__kde_jbm
__kde_papirus
__kde_adw_gtk
