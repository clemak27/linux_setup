DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: dotfiles/dev
dotfiles/dev: ## setup development tools
	mkdir -p "$$HOME/.local/bin"
	rm "$$HOME/.npmrc"
	rm "$$HOME/.config/go/env"
	echo -e "prefix=~/.local/bin/npm\nsave-exact=true" > "$$HOME/.npmrc"
	echo "GOTOOLCHAIN=local" > "$$HOME/.config/go/env"
