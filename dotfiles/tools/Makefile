DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: tools
tools:
	mkdir -p "$(CONFIG)/bat"
	ln -sf "$(DOTFILES)/tools/bat.config" "$(CONFIG)/bat/config"
	mkdir -p "$$HOME/.local/bin"
	mkdir -p "$(CONFIG)/tealdeer"
	ln -sf "$(DOTFILES)/tools/tealdeer.toml" "$(CONFIG)/tealdeer/config.toml"
	ln -sf "$(DOTFILES)/tools/cdp" "$$HOME/.local/bin/cdp"
	# TODO go install github.com/sachaos/viddy@latest
