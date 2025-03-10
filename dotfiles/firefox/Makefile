.PHONY: dotfiles/firefox
dotfiles/firefox: ## setup firefox
	# rpm-ostree override remove firefox firefox-langpacks
	# https://github.com/fedora-silverblue/silverblue-docs/blob/master/modules/ROOT/pages/tips-and-tricks.adoc#hiding-the-default-browser-firefox
	sudo mkdir -p /usr/local/share/applications/
	sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
	sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
	sudo update-desktop-database /usr/local/share/applications/
	flatpak install -y flathub \
		org.freedesktop.Platform.ffmpeg-full \
		org.mozilla.firefox
	flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
	echo 'flatpak run org.mozilla.firefox "$$@"' > "$$HOME/.local/bin/firefox"
	chmod +x "$$HOME/.local/bin/firefox"
	mkdir -p $$XDG_DATA_HOME/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies
	cp $(DOTFILES)/firefox/policies.json $$XDG_DATA_HOME/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies/policies.json


# "firefoxpwa@filips.si": {
#   "install_url": "https://addons.mozilla.org/firefox/downloads/file/4437768/latest.xpi",
#   "installation_mode": "force_installed"
# },
