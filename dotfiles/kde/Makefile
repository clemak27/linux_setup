DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

  # local CONF="/home/${YOUR_USER}/.config/dolphinrc"
  # kwriteconfig6 --file "${CONF}" --group "General" --key "ShowSpaceInfo" "false"
	#
.PHONY: dotfiles/kde
dotfiles/kde: ksshaskpass bbColorscheme konsoleTheme ## setup KDE Plasma
	kwriteconfig6 --file "$(CONFIG)/dolphinrc" --group "DetailsMode" --key "ExpandableFolders" "false"
	kwriteconfig6 --file "$(CONFIG)/dolphinrc" --group "DetailsMode" --key "PreviewSize" "32"
	kwriteconfig6 --file "$(CONFIG)/dolphinrc" --group "General" --key "ConfirmClosingMultipleTabs" "false"
	kwriteconfig6 --file "$(CONFIG)/dolphinrc" --group "General" --key "RememberOpenedTabs" "false"
	kwriteconfig6 --file "$(CONFIG)/dolphinrc" --group "General" --key "ShowZoomSlider" "false"
	kwriteconfig6 --file "$(CONFIG)/dolphinrc" --group "KFileDialog Settings" --key "Places Icons Auto-resize" "false"
	kwriteconfig6 --file "$(CONFIG)/dolphinrc" --group "KFileDialog Settings" --key "Places Icons Static Size" "22"

	kwriteconfig6 --file "$(CONFIG)/kcminputrc" --group "Mouse" --key "cursorTheme" "breeze_cursors"

	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "General" --key "accentColorFromWallpaper" "true"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "Icons" --key "Theme" "Papirus-Dark"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KDE" --key "ShowDeleteCommand" "false"

	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Allow Expansion" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Automatically select filename extension" "true"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Breadcrumb Navigation" "true"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Decoration position" "2"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "LocationCombo Completionmode" "5"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "PathCombo Completionmode" "5"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Show Bookmarks" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Show Full Path" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Show Inline Previews" "true"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Show Preview" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Show Speedbar" "true"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Show hidden files" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Sort by" "Name"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Sort directories first" "true"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Sort hidden files last" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Sort reversed" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "Speedbar Width" "140"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "KFileDialog Settings" --key "View Style" "DetailTree"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "PreviewSettings" --key "EnableRemoteFolderThumbnail" "false"
	kwriteconfig6 --file "$(CONFIG)/kdeglobals" --group "PreviewSettings" --key "MaximumRemoteSize" "0"

	kwriteconfig6 --file "$(CONFIG)/kiorc" --group "Confirmations" --key "ConfirmDelete" "true"
	kwriteconfig6 --file "$(CONFIG)/kiorc" --group "Confirmations" --key "ConfirmEmptyTrash" "true"
	kwriteconfig6 --file "$(CONFIG)/kiorc" --group "Confirmations" --key "ConfirmTrash" "false"
	kwriteconfig6 --file "$(CONFIG)/kiorc" --group "Executable scripts" --key "behaviourOnLaunch" "alwaysAsk"

	kwriteconfig6 --file "$(CONFIG)/klaunchrc" --group "BusyCursorSettings" --key "Bouncing" "false"
	kwriteconfig6 --file "$(CONFIG)/krunnerrc" --group "General" --key "FreeFloating" "true"
	kwriteconfig6 --file "$(CONFIG)/krunnerrc" --group "Plugins" --key "krunner_katesessionsEnabled" "false"
	kwriteconfig6 --file "$(CONFIG)/krunnerrc" --group "Plugins" --key "krunner_konsoleprofilesEnabled" "false"
	kwriteconfig6 --file "$(CONFIG)/krunnerrc" --group "Plugins/Favorites" --key "plugins" "krunner_services,krunner_systemsettings"
	kwriteconfig6 --file "$(CONFIG)/kscreenlockerrc" --group "Daemon" --key "Autolock" "false"
	kwriteconfig6 --file "$(CONFIG)/kscreenlockerrc" --group "Daemon" --key "Timeout" "0"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "Effect-overview" --key "BorderActivate" "9"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "NightColor" --key "Active" "true"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "NightColor" --key "NightTemperature" "4400"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "Plugins" --key "blurEnabled" "false"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "Plugins" --key "contrastEnabled" "false"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "Xwayland" --key "Scale" "1"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "org --key kde.kdecoration2"."ButtonsOnLeft" "X"
	kwriteconfig6 --file "$(CONFIG)/kwinrc" --group "org --key kde.kdecoration2"."ButtonsOnRight" "F"

	kwriteconfig6 "$(CONFIG)/kxkbrc" --group "Layout" --key "LayoutList" "us"
	kwriteconfig6 "$(CONFIG)/kxkbrc" --group "Layout" --key "Use" "true"
	kwriteconfig6 "$(CONFIG)/kxkbrc" --group "Layout" --key "VariantList" "altgr-intl"

	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LANG" "en_GB.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_ADDRESS" "de_AT.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_MEASUREMENT" "de_AT.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_MONETARY" "de_AT.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_NAME" "de_AT.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_NUMERIC" "de_AT.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_PAPER" "de_AT.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_TELEPHONE" "de_AT.UTF-8"
	kwriteconfig6 --file "$(CONFIG)/plasma-localerc" --group "Formats" --key "LC_TIME" "de_AT.UTF-8"

.PHONY: ksshaskpass
ksshaskpass:
	rpm-ostree install --idempotent ksshaskpass
	# flatpak install -y flathub \
	# 	org.kde.gwenview \
	# 	org.kde.okular
	mkdir -p $$HOME/.config/autostart
	echo -e "[Desktop Entry]\nExec=$$HOME/Projects/linux_setup/dotfiles/kde/kssaskpass.sh\nIcon=dialog-scripts\nName=kssaskpass.sh\nType=Application\nX-KDE-AutostartScript=true" > $$HOME/.config/autostart/kssaskpass.sh.desktop

.PHONY: bbColorscheme
bbColorscheme:
	ln -sf $(DOTFILES)/kde/BlackBreeze.colors $$HOME/.local/share/color-schemes

.PHONY: konsoleTheme
konsoleTheme:
	mkdir -p tmp $$HOME/.local/share/konsole
	ln -sf $(DOTFILES)/kde/MochaMatte.colorscheme $$HOME/.local/share/konsole
