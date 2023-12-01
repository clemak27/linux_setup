JBMONO_VERSION=3.0.2
ADW_GTK3_VERSION=3.6
ADW_GTK3_URL_VERSION=3-6
SPACER_AS_PAGER_VERSION=1.2.0
FEISHIN_VERSION=0.5.1

.PHONY: all
all: applications/base customization kde nix

.PHONY: test
test:

.PHONY: clean
clean:
	rm -rf tmp

.PHONY: argentum
argentum: applications/base applications/default applications/games extra/argentum customization kde nix

.PHONY: silfur
silfur: applications/base applications/default applications/games extra/silfur customization kde nix

.PHONY: deck
deck: customization catppuccinColorscheme konsoleTheme
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub org.mozilla.firefox org.freedesktop.Platform.ffmpeg-full io.mpv.Mpv \
		com.discordapp.Discord com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
		org.prismlauncher.PrismLauncher org.zdoom.GZDoom

### applications

.PHONY: applications/base
applications/base:
	rpm-ostree install --idempotent podman-docker vim make qemu-user-binfmt
	rpm-ostree override remove firefox firefox-langpacks
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub \
		org.freedesktop.Platform.ffmpeg-full \
		org.mozilla.firefox \
		org.wezfurlong.wezterm
	flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
	ln -sf $$PWD/dotfiles/wezterm.lua $$HOME/.wezterm.lua


.PHONY: applications/default
applications/default:
	flatpak install -y flathub \
		io.mpv.Mpv \
		org.gimp.GIMP \
		org.kde.kid3 \
		org.libreoffice.LibreOffice \
		org.mozilla.Thunderbird \
		org.pipewire.Helvum \
		org.signal.Signal
	mkdir -p $$HOME/.local/bin $$HOME/.local/share/applications
	curl -L --url https://github.com/jeffvli/feishin/releases/download/v$(FEISHIN_VERSION)/Feishin-$(FEISHIN_VERSION)-linux-x86_64.AppImage -o $$HOME/.local/bin/feishin
	chmod +x $$HOME/.local/bin/feishin
	echo -e "[Desktop Entry]\nName=Feishin\nExec=$$HOME/.local/bin/feishin\nType=Application\nCategories=Multimedia\nIcon=multimedia-audio-player" > $$HOME/.local/share/applications/feishin.desktop
	ln -sf $$PWD/dotfiles/mpv.conf $$HOME/.var/app/io.mpv.Mpv/config/mpv/mpv.conf

.PHONY: applications/games
applications/games:
	# TODO add gamemode
	flatpak install -y flathub \
		com.discordapp.Discord \
		com.valvesoftware.Steam \
		io.github.Foldex.AdwSteamGtk \
		org.freedesktop.Platform.VulkanLayer.MangoHud \
		org.freedesktop.Platform.VulkanLayer.gamescope \
		org.freedesktop.Platform.ffmpeg-full \
		com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
		org.prismlauncher.PrismLauncher \
		org.zdoom.GZDoom
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules
	sudo mv 60-steam-input.rules /etc/udev/rules.d/
	curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules
	sudo mv 60-steam-vr.rules /etc/udev/rules.d/

applications/kde:
	rpm-ostree install --idempotent ksshaskpass
	flatpak install -y flathub \
		org.kde.gwenview
	echo -e "[Desktop Entry]\nExec=$$HOME/Projects/linux_setup/kde/kssaskpass.sh\nIcon=dialog-scripts\nName=kssaskpass.sh\nType=Application\nX-KDE-AutostartScript=true" > $$HOME/.config/autostart/kssaskpass.sh.desktop

### host-specific setup

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
extra/silfur:
	rpm-ostree install --idempotent wireguard-tools
	# TODO update
	rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
	rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1
	sudo hostnamectl hostname silfur

### customization

.PHONY: customization
customization: jbMonoFont adwGtkTheme papirusIconTheme catppuccinCursor

.PHONY: jbMonoFont
jbMonoFont: jbMonoFont/download jbMonoFont/cleanup

.PHONY: jbMonoFont/download
jbMonoFont/download:
	mkdir -p tmp $$HOME/.local/share/fonts
	curl -Lo tmp/jbMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v$(JBMONO_VERSION)/JetBrainsMono.zip"
	unzip -o tmp/jbMono.zip -d $$HOME/.local/share/fonts

.PHONY: jbMonoFont/cleanup
jbMonoFont/cleanup:
	cd $$HOME/.local/share/fonts && find JetBrainsMonoNerdFontPropo* | xargs rm -f
	cd $$HOME/.local/share/fonts && find JetBrainsMonoNerdFontMono* | xargs rm -f
	cd $$HOME/.local/share/fonts && find JetBrainsMonoNL* | xargs rm -f
	cd $$HOME/.local/share/fonts && rm OFL.txt && rm readme.md

.PHONY: adwGtkTheme
adwGtkTheme:
	mkdir -p tmp $$HOME/.local/share/themes
	curl -Lo tmp/adw-gtk3.tar.xz --url https://github.com/lassekongo83/adw-gtk3/releases/download/v$(ADW_GTK3_VERSION)/adw-gtk3v$(ADW_GTK3_URL_VERSION).tar.xz
	tar xf tmp/adw-gtk3.tar.xz --directory $$HOME/.local/share/themes
	flatpak install -y com.github.GradienceTeam.Gradience org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
	flatpak override --user --filesystem=xdg-config/gtk-3.0 --filesystem=xdg-config/gtk-4.0

.PHONY: papirusIconTheme
papirusIconTheme:
	wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$$HOME/.local/share/icons" sh

.PHONY: catppuccinCursor
catppuccinCursor:
	mkdir -p tmp $$HOME/.local/share/icons
	rm -rf tmp/catppuccinCursor
	git clone https://github.com/catppuccin/cursors.git tmp/catppuccinCursor
	unzip -o tmp/catppuccinCursor/cursors/Catppuccin-Mocha-Dark-Cursors.zip -d $$HOME/.local/share/icons

### kde customization

.PHONY: kde
kde: applications/kde catppuccinColorscheme konsoleTheme spacerAsPager customPanel

.PHONY: catppuccinColorscheme
catppuccinColorscheme:
	mkdir -p tmp/catppuccinColorscheme $$HOME/.local/share/color-schemes
	curl -Lo tmp/catppuccinColorscheme.tar.gz "https://github.com/catppuccin/kde/releases/download/v0.2.4/Mocha-color-schemes.tar.gz"
	tar xf tmp/catppuccinColorscheme.tar.gz --directory tmp/catppuccinColorscheme
	cp tmp/catppuccinColorscheme/Mocha-color-schemes/CatppuccinMochaMauve.colors $$HOME/.local/share/color-schemes/CatppuccinMochaMauve.colors

.PHONY: konsoleTheme
konsoleTheme:
	mkdir -p tmp $$HOME/.local/share/konsole
	rm -rf tmp/konsole
	cd tmp && git clone https://github.com/catppuccin/konsole
	cp tmp/konsole/Catppuccin-Mocha.colorscheme $$HOME/.local/share/konsole

.PHONY: spacerAsPager
spacerAsPager:
	mkdir -p tmp/spacerAsPager
	rm -rf tmp/spacerAsPager/plasmoid-spacer-as-pager
	cd tmp/spacerAsPager && \
	git clone https://github.com/eatsu/plasmoid-spacer-as-pager.git --branch=$(SPACER_AS_PAGER_VERSION) && \
	cd plasmoid-spacer-as-pager && kpackagetool5 -i package

.PHONY: customPanel
customPanel:
	mkdir -p $$HOME/.local/share/plasma/layout-templates
	cp -R ./kde/panel $$HOME/.local/share/plasma/layout-templates/org.kde.plasma.desktop.customPanel

### nix + home-manager

.PHONY: nix
nix:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm && \
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && \
	nix run home-manager/master -- init --switch && \
	rm -rf $$HOME/.config/home-manager/ && \
	home-manager switch --flake . --impure

.PHONY: update-flake
update-flake:
	nix flake update --commit-lock-file  --option commit-lockfile-summary "chore: update flake"
