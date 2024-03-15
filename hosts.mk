### host-specific setup

.PHONY: argentum
argentum: applications/basic applications/default applications/games extra/argentum customization kde

.PHONY: silfur
silfur: applications/basic applications/default applications/games extra/silfur customization kde

.PHONY: deck
deck: customization catppuccinColorscheme konsoleTheme
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub org.mozilla.firefox org.freedesktop.Platform.ffmpeg-full io.mpv.Mpv \
		com.discordapp.Discord com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
		org.prismlauncher.PrismLauncher org.zdoom.GZDoom
	echo -e "[Desktop Entry]\nName=Youtube TV\nComment=Browse youtube in a bigger UI\nExec=/usr/bin/flatpak run --branch=stable --arch=x86_64 org.mozilla.firefox --command=firefox --kiosk --new-window youtube.com\nIcon=org.mozilla.firefox\nTerminal=false\nType=Application" > $$HOME/.local/share/applications/org.mozilla.firefox.tv.desktop

.PHONY: extra/argentum
extra/argentum:
	mkdir -p $$HOME/.local/share/applications
	flatpak install -y flathub org.openrgb.OpenRGB
	curl -LO https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+64+AppImage&inline=false
	sudo mv 60-openrgb.rules /etc/udev/rules.d/
	sudo udevadm control --reload-rules
	sudo udevadm trigger
	sudo hostnamectl hostname argentum

.PHONY: extra/silfur
extra/silfur: prime-run
	rpm-ostree install --idempotent wireguard-tools
	rpm-ostree install --idempotent --apply-live https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-39.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-39.noarch.rpm
	rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
	rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
	sudo hostnamectl hostname silfur

.PHONY: prime-run
prime-run:
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
