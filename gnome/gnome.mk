UNITE_VERSION=v78
SCROLL_VERSION=v36
BLUR_MY_SHELL_VERSION=v61
CATPPUCCIN_GTK_VERSION=0.7.3
### gnome customization

.PHONY: gnome
gnome: gnome/applications gnome/extensions gnome/dconf gnome/catppuccinGtk

.PHONY: gnome/applications
gnome/applications:
	rpm-ostree install --idempotent \
		gnome-shell-extension-appindicator \
		gnome-shell-extension-gsconnect \
		gnome-shell-extension-user-theme \
		gnome-tweaks \
		evolution
	flatpak install -y flathub \
		com.github.tchx84.Flatseal \
		org.gnome.Loupe \
		org.gnome.Weather \
		org.gnome.Calendar

.PHONY: gnome/extensions
gnome/extensions:
	rpm-ostree install --idempotent xprop
	flatpak install -y flathub org.gnome.Extensions
	mkdir -p tmp
	mkdir -p $$HOME/.local/share/gnome-shell/extensions
	curl -L -o tmp/unite-shell-$(UNITE_VERSION).zip --url https://github.com/hardpixel/unite-shell/releases/download/$(UNITE_VERSION)/unite-shell-$(UNITE_VERSION).zip
	unzip tmp/unite-shell-$(UNITE_VERSION).zip -d $$HOME/.local/share/gnome-shell/extensions
	# https://github.com/hardpixel/unite-shell/issues/303#issuecomment-1193269456
	sudo flatpak override --filesystem=xdg-data/gnome-shell/extensions/unite@hardpixel.eu/styles
	curl -L -o tmp/scroll-workspaces-$(SCROLL_VERSION).zip --url https://extensions.gnome.org/extension-data/scroll-workspacesgfxmonk.net.$(SCROLL_VERSION).shell-extension.zip
	unzip tmp/scroll-workspaces-$(SCROLL_VERSION).zip -d $$HOME/.local/share/gnome-shell/extensions/scroll-workspaces@gfxmonk.net
	curl -L -o tmp/blur-my-shell@aunetx.zip --url https://github.com/aunetx/blur-my-shell/releases/download/$(BLUR_MY_SHELL_VERSION)/blur-my-shell@aunetx.shell-extension.zip
	unzip tmp/blur-my-shell@aunetx.zip -d $$HOME/.local/share/gnome-shell/extensions/blur-my-shell@aunetx

.PHONY: gnome/dconf
gnome/dconf:
	dconf load / < ./gnome/dconf.txt

.PHONY: gnome/catppuccinGtk
gnome/catppuccinGtk:
	mkdir -p tmp $$HOME/.local/share/themes
	curl -Lo tmp/cp-gtk.zip --url https://github.com/catppuccin/gtk/releases/download/v$(CATPPUCCIN_GTK_VERSION)/Catppuccin-Mocha-Standard-Blue-Dark.zip
	unzip tmp/cp-gtk.zip -d $$HOME/.local/share/themes
