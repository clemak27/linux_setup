help: ## Show this help.
	@grep -F -h "##" $(MAKEFILE_LIST) | grep -F -v grep -F | sed -e 's/\\$$//' | sed -e 's/##//'

include dotfiles/dev/Makefile
include dotfiles/firefox/Makefile
include dotfiles/gaming/Makefile
include dotfiles/git/Makefile
include dotfiles/kde/Makefile
include dotfiles/nvim/Makefile
include dotfiles/syncthing/Makefile
include dotfiles/tools/Makefile
include dotfiles/wezterm/Makefile
include dotfiles/zsh/Makefile

upgrade: ## Upgrade the system
	rpm-ostree upgrade
	flatpak update -y
	distrobox enter wezterm -- paru -Syu

DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

git-per-host:
	git config --global user.signingkey "$$(cat $$HOME/.ssh/id_ed25519.pub)"
	echo "$$(git config --global user.email) $$(cat $$HOME/.ssh/id_ed25519.pub)" > $$HOME/.ssh/allowed_signers
	echo 	'' >> $(CONFIG)/git/config
	echo 	'[user]' >> $(CONFIG)/git/config
	echo 	'  email = "clemak27@mailbox.org"' >> $(CONFIG)/git/config
	echo 	'  name = "clemak27"' >> $(CONFIG)/git/config
	echo 	'  signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCyRaO8psuZI2i/+inKS5jn765Uypds8ORj/nVkgSE3 maxwell"' >> $(CONFIG)/git/config

# To set up TPM2 unlocking, first, find the LUKS device you want to enroll. This is probably in /etc/crypttab. You can also use sudo cryptsetup status /dev/mapper/luks* to identify the device.
#
# $ sudo rpm-ostree kargs --append=rd.luks.options=tpm2-device=auto
# $ sudo rpm-ostree initramfs --enable --arg=-a --arg=systemd-pcrphase
#
# Then, using the device you identified with 'crpysetup status' previously, enroll the device:
#
# $ sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/boot-device
