upgrade:
	nix flake update --commit-lock-file --option commit-lockfile-summary "chore(flake): update flake.lock"
	nixos-rebuild build --flake . --impure
	nvd diff /run/current-system result/
	sudo nixos-rebuild boot --flake . --impure
	git push
	flatpak update -y
	systemctl reboot
