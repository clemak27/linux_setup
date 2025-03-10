DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: hosts/newton
hosts/newton: dotfiles/dev dotfiles/firefox dotfiles/gaming dotfiles/git dotfiles/kde dotfiles/nvim dotfiles/syncthing dotfiles/tools dotfiles/wezterm dotfiles/zsh
	# git
	git config --global user.signingkey "$$(cat $$HOME/.ssh/id_ed25519.pub)"
	echo "$$(git config --global user.email) $$(cat $$HOME/.ssh/id_ed25519.pub)" > $$HOME/.ssh/allowed_signers
	echo 	'' >> $(CONFIG)/git/config
	echo 	'[user]' >> $(CONFIG)/git/config
	echo 	'  email = "clemak27@mailbox.org"' >> $(CONFIG)/git/config
	echo 	'  name = "clemak27"' >> $(CONFIG)/git/config
	echo 	'  signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3PSHWVz5/LwHEEfo+7y2o5KH7dlLyfySWnyyi7LLxe newton"' >> $(CONFIG)/git/config
	# wg
	rpm-ostree install --idempotent wireguard-tools
	# shit gpu
	rpm-ostree install --idempotent --apply-live https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm
	rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
	rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
	echo "#!/bin/sh" > prime-run
	echo  >> prime-run
	echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> prime-run
	echo "export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0" >> prime-run
	echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> prime-run
	echo "export __VK_LAYER_NV_optimus=NVIDIA_only" >> prime-run
	echo "export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json" >> prime-run
	echo 'exec -a "$$0" "$$@"' >> prime-run
	chmod +x prime-run
	sudo mv prime-run /usr/local/bin
