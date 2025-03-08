### link dotfiles

DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: dotfiles
dotfiles: dotfiles/dev dotfiles/git dotfiles/nvim dotfiles/tools dotfiles/k8s dotfiles/zsh dotfiles/todo

.PHONY: dotfiles/dev
dotfiles/dev:
	ln -sf "$(DOTFILES)/dev/npmrc" "$$HOME/.npmrc"

.PHONY: dotfiles/git
dotfiles/git:
	mkdir -p "$(CONFIG)/git"
	mkdir -p "$$HOME/.local/bin"
	ln -sf "$(DOTFILES)/git/lg" "$$HOME/.local/bin/lg"
	cp "$(DOTFILES)/git/config" "$(CONFIG)/git/config"
	git config --global user.signingkey "$$(cat $$HOME/.ssh/id_ed25519.pub)"
	echo "$$(git config --global user.email) $$(cat $$HOME/.ssh/id_ed25519.pub)" > $$HOME/.ssh/allowed_signers

.PHONY: dotfiles/nvim
dotfiles/nvim:
	rm -rf "$(CONFIG)/nvim"
	mkdir -p "$(CONFIG)/nvim"
	ln -sf "$(DOTFILES)/nvim/init.lua" "$(CONFIG)/nvim/init.lua"
	ln -sf "$(DOTFILES)/nvim/lua" "$(CONFIG)/nvim/lua"
	mkdir -p "$(CONFIG)/yamlfmt"
	ln -sf "$(DOTFILES)/nvim/yamlfmt.yaml" "$(CONFIG)/yamlfmt/.yamlfmt"
	ln -sf "$(DOTFILES)/nvim/markdownlintrc.json" "$$HOME/.markdownlintrc"
	ln -sf "$(DOTFILES)/nvim/snippets" "$(CONFIG)/nvim/snippets"
	ln -sf "$(DOTFILES)/nvim/jdtls-fmt.xml" "$$HOME/.jdtls-fmt.xml"
	ln -sf "$(DOTFILES)/nvim/editorconfig.ini" "$$HOME/.editorconfig"

.PHONY: dotfiles/tools
dotfiles/tools:
	mkdir -p "$(CONFIG)/bat"
	ln -sf "$(DOTFILES)/tools/bat.config" "$(CONFIG)/bat/config"
	mkdir -p "$$HOME/.local/bin"
	mkdir -p "$(CONFIG)/tealdeer"
	ln -sf "$(DOTFILES)/tools/tealdeer.toml" "$(CONFIG)/tealdeer/config.toml"
	go install github.com/sachaos/viddy@latest
	ln -sf "$(DOTFILES)/tools/cdp" "$$HOME/.local/bin/cdp"

.PHONY: dotfiles/k8s
dotfiles/k8s:
	go install github.com/hidetatz/kubecolor/cmd/kubecolor@latest

.PHONY: dotfiles/zsh
dotfiles/zsh:
	[[ -d $$HOME/.oh-my-zsh ]] || (curl -fsSL -o omz.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && omz.sh && rm -f omz.sh)
	[[ -d $$HOME/.oh-my-zsh/custom/plugins/gradle-completion ]] || git clone https://github.com/gradle/gradle-completion $$HOME/.oh-my-zsh/custom/plugins/gradle-completion
	ln -sf "$(DOTFILES)/zsh/zshrc" "$$HOME/.zshrc"
	ln -sf "$(DOTFILES)/zsh/starship.toml" "$(CONFIG)/starship.toml"
	rm -rf "$$HOME/.zsh_functions"
	ln -sf "$(DOTFILES)/zsh/zsh_functions" "$$HOME/.zsh_functions"
