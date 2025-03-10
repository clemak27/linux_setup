### host-specific setup

.PHONY: silfur
silfur: applications/basic applications/default applications/games extra/silfur customization kde

.PHONY: deck
deck: customization catppuccinColorscheme konsoleTheme dotfiles/zsh dotfiles/git
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub org.mozilla.firefox org.freedesktop.Platform.ffmpeg-full io.mpv.Mpv \
		com.discordapp.Discord com.valvesoftware.Steam.CompatibilityTool.Proton-GE
	echo -e "[Desktop Entry]\nName=Youtube TV\nComment=Browse youtube in a bigger UI\nExec=/usr/bin/flatpak run --branch=stable --arch=x86_64 org.mozilla.firefox --command=firefox --kiosk --new-window youtube.com\nIcon=org.mozilla.firefox\nTerminal=false\nType=Application" > $$HOME/.local/share/applications/org.mozilla.firefox.tv.desktop

.PHONY: extra/silfur
extra/silfur: prime-run
