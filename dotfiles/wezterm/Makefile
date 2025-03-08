.PHONY: wezterm
wezterm:
	# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	# flatpak install -y flathub org.wezfurlong.wezterm
	mkdir -p $$HOME/.config/wezterm
	ln -sf $$PWD/dotfiles/wezterm/wezterm.lua $$HOME/.config/wezterm/wezterm.lua
	ln -sf $$PWD/dotfiles/wezterm/bindings.lua $$HOME/.config/wezterm/bindings.lua
	# echo 'flatpak run org.wezfurlong.wezterm "$$@"' > "$$HOME/.local/bin/wezterm"
	# chmod +x "$$HOME/.local/bin/wezterm"

