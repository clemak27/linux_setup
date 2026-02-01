#!/bin/bash

set -eo pipefail

if [[ -n "$TERMUX_VERSION" ]]; then
  # termux-change-repo
  # termux-setup-storage
  # pkg install -y git
  # mkdir -p .config ~/Projects
  # cd Projects
  # git clone https://github.com/clemak27/linux_setup
  # cd linux_setup
  # ./setup/termux/setup.sh

  echo "symlink storage"

  rm -rf "$HOME/Downloads"
  ln -sf "$HOME/storage/downloads" "$HOME/Downloads"
  rm -rf "$HOME/Pictures"
  ln -sf "$HOME/storage/pictures" "$HOME/Pictures"
  rm -rf "$HOME/Music"
  ln -sf "$HOME/storage/music" "$HOME/Music"

  echo "install packages"

  pkg install -y zsh starship zsh-completions \
    git git-delta lazygit \
    bat chezmoi eza fd fzf htop jq yazi ripgrep sd tealdeer tree unrar unzip
  chsh -s zsh

  echo "setup colors"

  mkdir -p "$HOME/.termux"
  cat <<- EOF > "$HOME/.termux/colors.properties"
	  foreground=#cdd6f4
	  background=#121212
	  cursor=#f5e0dc
	  color0=#45475a
	  color1=#f38ba8
	  color2=#a6e3a1
	  color3=#f9e2af
	  color4=#89b4fa
	  color5=#f5c2e7
	  color6=#94e2d5
	  color7=#bac2de
	  color8=#585b70
	  color9=#f38ba8
	  color10=#a6e3a1
	  color11=#f9e2af
	  color12=#89b4fa
	  color13=#f5c2e7
	  color14=#94e2d5
	  color15=#a6adc8
	  color16=#fab387
	  color17=#f5e0dc
	EOF

  echo "download font"

  curl -L \
    --url https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFontMono-Regular.ttf \
    -o "$HOME/.termux/font.ttf"

  echo "symlink dotfiles"
  # this is easier than maintaining a list in .chezmoiignore, since termux needs just a few files

  ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_zshrc" "$HOME/.zshrc"
  ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/starship.toml" "$HOME/.config/starship.toml"

  mkdir -p "$HOME/.config/bat"
  ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/bat/config" "$HOME/.config/bat/config"

  mkdir -p "$HOME/.config/git"
  chezmoi execute-template -f "$HOME/Projects/linux_setup/dotfiles/dot_config/git/config.tmpl" > "$HOME/.config/git/config"

  mkdir -p "$HOME/.config/lazygit"
  cp --remove-destination "$HOME/Projects/linux_setup/dotfiles/dot_config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
  printf "gui:\n  enlargedSideViewLocation: top" >> "$HOME/.config/lazygit/config.yml"

  mkdir -p "$HOME/.config/tealdeer"
  ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/tealdeer/config.toml" "$HOME/.config/tealdeer/config.toml"

  mkdir -p "$HOME/.config/yt-dlp"
  ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/yt-dlp/config" "$HOME/.config/yt-dlp/config"

  mkdir -p "$HOME/.local/bin"
  cp --remove-destination "$HOME/Projects/linux_setup/dotfiles/dot_local/bin/executable_gcmld" "$HOME/.local/bin/gcmld"
  chmod u+x "$HOME/.local/bin/gcmld"
fi

sudo -v

## base

if lsb_release -as | grep "Bazzite"; then
  if [ "$HOSTNAME" != "fermi" ]; then
    ujust switch-to-ext4
    ujust setup-luks-tpm-unlock
    hostnamectl hostname fermi
    systemctl reboot
  fi

  if flatpak list | grep Flatseal &> /dev/null; then flatpak uninstall -y com.github.tchx84.Flatseal; fi

elif [ "$HOSTNAME" = "newton" ]; then
  # shit gpu
  rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
  rpm-ostree kargs \
    --append-if-missing=rd.driver.blacklist=nouveau,nova_core \
    --append-if-missing=modprobe.blacklist=nouveau,nova_core \
    --append-if-missing=nvidia-drm.modeset=1 \
    --append-if-missing=initcall_blacklist=simpledrm_platform_driver_init
fi

if [ "$XDG_CURRENT_DESKTOP" == "niri" ]; then
  gsettings set org.gnome.desktop.wm.preferences button-layout ':close'
  systemctl --user enable --now gcr-ssh-agent.socket
  systemctl --user enable --now gcr-ssh-agent.service
fi

## brew

brew_dir="/var/home/linuxbrew/.linuxbrew"

export HOMEBREW_CELLAR=$brew_dir/Cellar
export HOMEBREW_PREFIX=$brew_dir
export HOMEBREW_REPOSITORY=$brew_dir/Homebrew
export HOMEBREW_NO_ANALYTICS=1
export PATH="$brew_dir/bin:$PATH"

brew bundle install --file "$HOME/Projects/linux_setup/dotfiles/dot_Brewfile"

## homedir

mkdir -p "$HOME/.config/chezmoi"
printf "sourceDir: %s/Projects/linux_setup" "$HOME" > "$HOME/.config/chezmoi/chezmoi.yaml"
chezmoi apply --force
mise trust -y
mise install -y

## syncthing

mkdir -p "$HOME/.local/state/syncthing"
systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger

systemctl reboot
