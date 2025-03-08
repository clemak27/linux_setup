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

