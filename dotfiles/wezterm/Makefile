.PHONY: dotfiles/wezterm
dotfiles/wezterm: ## setup wezterm-container
	distrobox assemble create --file $(DOTFILES)/wezterm/distrobox.ini --name wezterm --replace
	distrobox enter wezterm -- distrobox-export --app wezterm
	distrobox enter wezterm -- rm -rf $$HOME/.cache/paru && git clone https://aur.archlinux.org/paru.git $$HOME/.cache/paru
	distrobox enter wezterm -- zsh -c "cd $$HOME/.cache/paru && makepkg -si --noconfirm"
	distrobox enter wezterm -- paru -Syu --noconfirm viddy kubecolor
	distrobox enter wezterm -- rm -rf $$HOME/.cache/paru
	mkdir -p $(CONFIG)/wezterm
	ln -sf $$PWD/dotfiles/wezterm/wezterm.lua $(CONFIG)/wezterm/wezterm.lua
	ln -sf $$PWD/dotfiles/wezterm/bindings.lua $(CONFIG)/wezterm/bindings.lua
	# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	# flatpak install -y flathub org.wezfurlong.wezterm
	# echo 'flatpak run org.wezfurlong.wezterm "$$@"' > "$$HOME/.local/bin/wezterm"
	# chmod +x "$$HOME/.local/bin/wezterm"

