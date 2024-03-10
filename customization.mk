### customization

JBMONO_VERSION=3.0.2
ADW_GTK3_VERSION=3.6
ADW_GTK3_URL_VERSION=3-6

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
