SPACER_AS_PAGER_VERSION=1.3.0

### kde customization

.PHONY: kde
kde: applications/kde catppuccinColorscheme catppuccinColorschemeDarker konsoleTheme spacerAsPager customPanel

.PHONY: catppuccinColorscheme
catppuccinColorscheme:
	mkdir -p tmp/catppuccinColorscheme $$HOME/.local/share/color-schemes
	curl -Lo tmp/catppuccinColorscheme.tar.gz "https://github.com/catppuccin/kde/releases/download/v0.2.4/Mocha-color-schemes.tar.gz"
	tar xf tmp/catppuccinColorscheme.tar.gz --directory tmp/catppuccinColorscheme
	cp tmp/catppuccinColorscheme/Mocha-color-schemes/CatppuccinMochaMauve.colors $$HOME/.local/share/color-schemes/CatppuccinMochaMauve.colors

.PHONY: catppuccinColorschemeDarker
catppuccinColorschemeDarker:
	cp ./kde/CatppuccinMochaMauveDarker.colors $$HOME/.local/share/color-schemes/CatppuccinMochaMauveDarker.colors

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
	cd plasmoid-spacer-as-pager && kpackagetool5 -u package

.PHONY: customPanel
customPanel:
	mkdir -p $$HOME/.local/share/plasma/layout-templates
	cp -R ./kde/panel $$HOME/.local/share/plasma/layout-templates/org.kde.plasma.desktop.customPanel
