### applications

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

.PHONY: steambox
steambox:
	distrobox assemble create --name steambox --replace

.PHONY: applications/music
applications/music:
	flatpak install -y flathub \
		org.ardour.Ardour \
		org.freedesktop.LinuxAudio.Plugins.Surge-XT \
		org.guitarix.Guitarix
