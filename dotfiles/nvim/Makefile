.PHONY: dotfiles/nvim
dotfiles/nvim: ## setup neovim
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
