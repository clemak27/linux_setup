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

.PHONY: all
all: applications/base customization kde

.PHONY: clean
clean:
	rm -rf tmp


# To set up TPM2 unlocking, first, find the LUKS device you want to enroll. This is probably in /etc/crypttab. You can also use sudo cryptsetup status /dev/mapper/luks* to identify the device.
#
# $ sudo rpm-ostree kargs --append=rd.luks.options=tpm2-device=auto
# $ sudo rpm-ostree initramfs --enable --arg=-a --arg=systemd-pcrphase
#
# Then, using the device you identified with 'crpysetup status' previously, enroll the device:
#
# $ sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/boot-device
#
