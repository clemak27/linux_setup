upgrade:
	nix flake update --commit-lock-file --option commit-lockfile-summary "chore(flake): update flake.lock"
	nixos-rebuild build --flake . --impure
	nvd diff /run/current-system result/
	sudo nixos-rebuild boot --flake . --impure
	git push
	flatpak update -y
	systemctl reboot

flatpak: flatpak/user flatpak/system
	sudo flatpak override --filesystem=xdg-config/gtk-3.0
	sudo flatpak override --filesystem=xdg-config/gtk-4.0

flatpak/system:
	flatpak install -y --system flathub \
    org.freedesktop.Platform.VulkanLayer.MangoHud//24.08 \
    org.freedesktop.Platform.VulkanLayer.gamescope//24.08

flatpak/user:
	flatpak install -y --user flathub \
    com.calibre_ebook.calibre \
    com.obsproject.Studio \
    com.valvesoftware.Steam \
    com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
    dev.vencord.Vesktop \
    org.freedesktop.Platform.ffmpeg-full//24.08 \
    org.gtk.Gtk3theme.adw-gtk3 \
    org.gtk.Gtk3theme.adw-gtk3-dark \
    org.libreoffice.LibreOffice \
    org.pipewire.Helvum \
    org.signal.Signal
