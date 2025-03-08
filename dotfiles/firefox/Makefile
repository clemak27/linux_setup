.PHONY: firefox
firefox:
	rpm-ostree override remove firefox firefox-langpacks
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub \
		org.freedesktop.Platform.ffmpeg-full \
		org.mozilla.firefox
	flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
	echo 'flatpak run org.mozilla.firefox "$$@"' > "$$HOME/.local/bin/firefox"
	chmod +x "$$HOME/.local/bin/firefox"
	mkdir -p $$XDG_DATA_HOME/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies
	cp ./policies.json $$XDG_DATA_HOME/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies/policies.json


# "firefoxpwa@filips.si": {
#   "install_url": "https://addons.mozilla.org/firefox/downloads/file/4437768/latest.xpi",
#   "installation_mode": "force_installed"
# },
