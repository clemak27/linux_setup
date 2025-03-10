DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: hosts/maxwell
hosts/maxwell: dotfiles/dev dotfiles/firefox dotfiles/gaming dotfiles/git dotfiles/kde dotfiles/nvim dotfiles/syncthing dotfiles/tools dotfiles/wezterm dotfiles/zsh
	# git
	git config --global user.signingkey "$$(cat $$HOME/.ssh/id_ed25519.pub)"
	echo "$$(git config --global user.email) $$(cat $$HOME/.ssh/id_ed25519.pub)" > $$HOME/.ssh/allowed_signers
	echo 	'' >> $(CONFIG)/git/config
	echo 	'[user]' >> $(CONFIG)/git/config
	echo 	'  email = "clemak27@mailbox.org"' >> $(CONFIG)/git/config
	echo 	'  name = "clemak27"' >> $(CONFIG)/git/config
	echo 	'  signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCyRaO8psuZI2i/+inKS5jn765Uypds8ORj/nVkgSE3 maxwell"' >> $(CONFIG)/git/config
	# openrgb
	mkdir -p $$HOME/.local/share/applications
	flatpak install -y flathub org.openrgb.OpenRGB
	curl -LO https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+64+AppImage&inline=false
	sudo mv 60-openrgb.rules /etc/udev/rules.d/
	sudo udevadm control --reload-rules
	sudo udevadm trigger

	# /dev/disk/by-uuid/1d007512-92c1-40ba-8863-f50589b88437 /home/clemens/Games btrfs compress=zstd 0 0
	# 192.168.178.100:/media /home/clemens/nfs/media nfs x-systemd.automount,_netdev,x-systemd.idle-timeout=60,noauto 0 0
