.PHONY: dotfiles/gaming
dotfiles/gaming:
	rpm-ostree install --idempotent steam-devices gamemode
	flatpak install -y flathub \
		com.valvesoftware.Steam \
		com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
		dev.vencord.Vesktop \
		net.lutris.Lutris \
		net.retrodeck.retrodeck \
		org.freedesktop.Platform.VulkanLayer.MangoHud \
		org.freedesktop.Platform.VulkanLayer.gamescope \
		org.freedesktop.Platform.ffmpeg-full
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules
	sudo mv 60-steam-input.rules /etc/udev/rules.d/
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules
	sudo mv 60-steam-vr.rules /etc/udev/rules.d/
