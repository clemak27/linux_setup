### applications

FEISHIN_VERSION=0.5.3

.PHONY: applications
applications: applications/basic applications/default applications/games applications/kde

.PHONY: applications/base
applications/base:
	rpm-ostree install --idempotent vim make zsh distrobox
	# reboot is needed so the base packages are installed
	if ! command -v distrobox > /dev/null; then exit 1; fi
	sudo usermod -s /usr/bin/zsh clemens

.PHONY: applications/basic
applications/basic: podman firefox wezterm syncthing main


.PHONY: firefox
firefox:
	rpm-ostree override remove firefox firefox-langpacks
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub \
		org.freedesktop.Platform.ffmpeg-full \
		org.mozilla.firefox
	flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
	echo 'flatpak run org.mozilla.firefox "$@"' > "$$HOME/.local/bin/firefox"
	chmod +x "$$HOME/.local/bin/firefox"

.PHONY: wezterm
wezterm:
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub \
		org.wezfurlong.wezterm
	ln -sf $$PWD/dotfiles/wezterm.lua $$HOME/.wezterm.lua

.PHONY: podman
podman:
	rpm-ostree install --idempotent podman-docker
	sudo touch /etc/containers/nodocker
	systemctl --user enable podman.socket
	mkdir -p $$HOME/.config/containers
	# https://github.com/containers/podman/issues/5488
	echo -e "[engine]\nstatic_dir = \"/home/clemens/.local/share/containers/storage/libpod\"\nvolume_path = \"/home/clemens/.local/share/containers/storage/libpod\"" > $$HOME/.config/containers/containers.conf
	# https://github.com/containers/podman/issues/3234#issuecomment-497541854
	# https://github.com/containers/podman/issues/10817#issuecomment-1563103744
	restorecon -RFv /home/clemens/.local/share/containers

.PHONY: syncthing
syncthing:
	mkdir -p $$HOME/.config/containers/systemd
	cp syncthing.container $$HOME/.config/containers/systemd/syncthing.container
	systemctl --user daemon-reload
	systemctl --user start syncthing
	loginctl enable-linger

.PHONY: main
main: applications/base
	distrobox assemble create --name main

.PHONY: steambox
steambox:
	distrobox assemble create --name steambox

.PHONY: applications/default
applications/default:
	flatpak install -y flathub \
		io.mpv.Mpv \
		org.gimp.GIMP \
		org.kde.kid3 \
		org.libreoffice.LibreOffice \
		org.mozilla.Thunderbird \
		org.pipewire.Helvum \
		org.signal.Signal
	mkdir -p $$HOME/.local/bin $$HOME/.local/share/applications
	curl -L --url https://github.com/jeffvli/feishin/releases/download/v$(FEISHIN_VERSION)/Feishin-$(FEISHIN_VERSION)-linux-x86_64.AppImage -o $$HOME/.local/bin/feishin
	chmod +x $$HOME/.local/bin/feishin
	echo -e "[Desktop Entry]\nName=Feishin\nExec=$$HOME/.local/bin/feishin\nType=Application\nCategories=Multimedia\nIcon=multimedia-audio-player" > $$HOME/.local/share/applications/feishin.desktop
	ln -sf $$PWD/dotfiles/mpv.conf $$HOME/.var/app/io.mpv.Mpv/config/mpv/mpv.conf
	echo 'flatpak run io.mpv.Mpv "$@"' > "$$HOME/.local/bin/mpv"
	chmod +x "$$HOME/.local/bin/mpv"

.PHONY: applications/games
applications/games: applications/dsda
	# TODO add gamemode
	flatpak install -y flathub \
		com.discordapp.Discord \
		com.valvesoftware.Steam \
		io.github.Foldex.AdwSteamGtk \
		org.freedesktop.Platform.VulkanLayer.MangoHud \
		org.freedesktop.Platform.VulkanLayer.gamescope \
		org.freedesktop.Platform.ffmpeg-full \
		com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
		org.prismlauncher.PrismLauncher \
		org.zdoom.GZDoom
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules
	sudo mv 60-steam-input.rules /etc/udev/rules.d/
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules
	sudo mv 60-steam-vr.rules /etc/udev/rules.d/

applications/kde:
	rpm-ostree install --idempotent ksshaskpass
	flatpak install -y flathub \
		org.kde.gwenview \
		org.kde.okular
	echo -e "[Desktop Entry]\nExec=$$HOME/Projects/linux_setup/kde/kssaskpass.sh\nIcon=dialog-scripts\nName=kssaskpass.sh\nType=Application\nX-KDE-AutostartScript=true" > $$HOME/.config/autostart/kssaskpass.sh.desktop

.PHONY: applications/dsda
applications/dsda:
	distrobox assemble create --name dsda
