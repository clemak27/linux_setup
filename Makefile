help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

# include applications.mk
# include customization.mk
include dotfiles/dev
# include hosts.mk
# include ./gnome/gnome.mk

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
