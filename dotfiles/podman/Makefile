.PHONY: dotfiles/podman
dotfiles/podman:
	rpm-ostree install --idempotent podman-docker podman-compose
	sudo mkdir -p /etc/containers
	sudo touch /etc/containers/nodocker
	systemctl --user enable podman.socket
	mkdir -p $$HOME/.config/containers
	# https://github.com/containers/podman/issues/5488
	echo -e "[engine]\nstatic_dir = \"/home/clemens/.local/share/containers/storage/libpod\"\nvolume_path = \"/home/clemens/.local/share/containers/storage/libpod\"" > $$HOME/.config/containers/containers.conf
	# https://github.com/containers/podman/issues/3234#issuecomment-497541854
	# https://github.com/containers/podman/issues/10817#issuecomment-1563103744
	# restorecon -RFv /home/clemens/.local/share/containers
