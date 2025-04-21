## maintenance

update:
	rpm-ostree upgrade
	flatpak update -y
	if command -v paru > /dev/null; then paru -Syu --noconfirm; fi
	systemctl reboot

## dotfiles

.PHONY: dotfiles
dotfiles:
	$$HOME/.local/bin/chezmoi apply

.PHONY: dotfiles/init
dotfiles/init:
	curl -fsLS get.chezmoi.io > chmz
	chmod u+x chmz
	./chmz -b $$HOME/.local/bin
	rm -f chmz
	mkdir -p $$HOME/.config/chezmoi
	printf "sourceDir: $$PWD" > $$HOME/.config/chezmoi/chezmoi.yaml
	$$HOME/.local/bin/chezmoi apply
