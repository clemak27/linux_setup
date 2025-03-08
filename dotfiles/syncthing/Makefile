.PHONY: dotfiles/syncthing
dotfiles/syncthing: ## setup syncthing
	mkdir -p $$HOME/.config/containers/systemd
	cp syncthing.container $$HOME/.config/containers/systemd/syncthing.container
	systemctl --user daemon-reload
	systemctl --user start syncthing
	loginctl enable-linger

