DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: zsh
zsh:
	[[ -d $$HOME/.oh-my-zsh ]] || (curl -fsSL -o omz.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && omz.sh && rm -f omz.sh)
	[[ -d $$HOME/.oh-my-zsh/custom/plugins/gradle-completion ]] || git clone https://github.com/gradle/gradle-completion $$HOME/.oh-my-zsh/custom/plugins/gradle-completion
	ln -sf "$(DOTFILES)/zsh/zshrc" "$$HOME/.zshrc"
	ln -sf "$(DOTFILES)/zsh/starship.toml" "$(CONFIG)/starship.toml"
	rm -rf "$$HOME/.zsh_functions"
	ln -sf "$(DOTFILES)/zsh/zsh_functions" "$$HOME/.zsh_functions"
