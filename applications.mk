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
applications/basic: podman main

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
	# restorecon -RFv /home/clemens/.local/share/containers

.PHONY: main
main: applications/base
	distrobox assemble create --name wezterm --replace

.PHONY: steambox
steambox:
	distrobox assemble create --name steambox --replace

.PHONY: applications/default
applications/default:
	flatpak install -y flathub \
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

.PHONY: applications/games
applications/games: applications/dsda
	flatpak install -y flathub \
		com.valvesoftware.Steam \
		dev.vencord.Vesktop \
		io.github.Foldex.AdwSteamGtk \
		net.lutris.Lutris \
		org.freedesktop.Platform.VulkanLayer.MangoHud \
		org.freedesktop.Platform.VulkanLayer.gamescope \
		org.freedesktop.Platform.ffmpeg-full \
		org.prismlauncher.PrismLauncher \
		org.zdoom.GZDoom
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules
	sudo mv 60-steam-input.rules /etc/udev/rules.d/
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules
	sudo mv 60-steam-vr.rules /etc/udev/rules.d/

.PHONY: applications/dsda
applications/dsda:
	distrobox assemble create --name dsda --replace

.PHONY: applications/music
applications/music:
	flatpak install -y flathub \
		org.ardour.Ardour \
		org.freedesktop.LinuxAudio.Plugins.Surge-XT \
		org.guitarix.Guitarix
