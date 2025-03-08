DOTFILES=$$PWD/dotfiles
CONFIG=$$HOME/.config

.PHONY: git
git:
	mkdir -p "$(CONFIG)/git"
	mkdir -p "$$HOME/.local/bin"
	ln -sf "$(DOTFILES)/git/lg" "$$HOME/.local/bin/lg"
	cp "$(DOTFILES)/git/config" "$(CONFIG)/git/config"
	git config --global user.signingkey "$$(cat $$HOME/.ssh/id_ed25519.pub)"
	echo "$$(git config --global user.email) $$(cat $$HOME/.ssh/id_ed25519.pub)" > $$HOME/.ssh/allowed_signers
