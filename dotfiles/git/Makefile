DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: dotfiles/git
dotfiles/git: ## setup git
	mkdir -p "$(CONFIG)/git"
	mkdir -p "$(CONFIG)/lazygit"
	mkdir -p "$$HOME/.local/bin"
	ln -sf "$(DOTFILES)/git/lg" "$$HOME/.local/bin/lg"
	ln -sf "$(DOTFILES)/git/gcmld" "$$HOME/.local/bin/gcmld"
	cp "$(DOTFILES)/git/config" "$(CONFIG)/git/config"
	ln -sf "$(DOTFILES)/git/lgconfig" "$(CONFIG)/lazygit/config.yml"
