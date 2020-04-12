#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
if [ -f ./config.sh ]; then
  source ./config.sh
else
  echo "Config file could not be found!"
  exit 1
fi

#------

# https://zren.github.io/kde/

xdg-user-dirs-update

# nvim config
mkdir -p ~/.config/nvim
cp dotfiles/vimrc ~/.config/nvim/init.vim

# plug-vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
cp dotfiles/p10k ~/.p10k.zsh
cp dotfiles/zshrc ~/.zshrc
chsh -s /usr/bin/zsh

# git config
git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global credential.helper "cache --timeout=86400"

mkdir -p ~/Projects

#yay
cd ~/Projects
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# aur
sudo pacman -S --noconfirm automake autoconf
yay -S --noconfirm cava tty-clock gotop-bin ddgr

#--------------------module dependencies--------------------

# python dev packages
if [[ " ${modules[@]} " =~ "python" ]]; then
  pip install jedi pylint --user
fi

# go dev binaries
if [[ " ${modules[@]} " =~ "go" ]]; then
  mkdir -p ~/.go
  export GOPATH=~/.go
  go get github.com/klauspost/asmfmt/cmd/asmfmt
  go get github.com/go-delve/delve/cmd/dlv
  go get github.com/kisielk/errcheck
  go get github.com/davidrjenni/reftools/cmd/fillstruct
  go get github.com/mdempsky/gocode
  go get github.com/stamblerre/gocode
  go get github.com/rogpeppe/godef
  go get github.com/zmb3/gogetdoc
  go get golang.org/x/tools/cmd/goimports
  go get golang.org/x/lint/golint
  go get golang.org/x/tools/gopls
  go get github.com/golangci/golangci-lint/cmd/golangci-lint
  go get github.com/fatih/gomodifytags
  go get golang.org/x/tools/cmd/gorename
  go get github.com/jstemmer/gotags
  go get golang.org/x/tools/cmd/guru
  go get github.com/josharian/impl
  go get honnef.co/go/tools/cmd/keyify
  go get github.com/fatih/motion
  go get github.com/koron/iferr
fi

# rust dev
if [[ " ${modules[@]} " =~ "rust" ]]; then
  # path schon in zshrc
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if [[ " ${modules[@]} " =~ "gaming" ]]; then
  yay -S --noconfirm steam-fonts
fi

if [[ " ${modules[@]} " =~ "gui" ]]; then
  yay -S --noconfirm spotify

  # mpv config
  cp -r /usr/share/doc/mpv/ ~/.config/
  sed -i 's/#autofit-larger=90%x90%/autofit-larger=40%x40%/g' ~/.config/mpv/mpv.conf
  echo "" >> ~/.config/mpv/mpv.conf
  echo 'ytdl-format="bestvideo[height<=?1080]+bestaudio/best"' >> ~/.config/mpv/mpv.conf
  echo 'no-keepaspect-window' >> ~/.config/mpv/mpv.conf
  echo 'x11-bypass-compositor=no' >> ~/.config/mpv/mpv.conf
fi

if [[ " ${modules[@]} " =~ "syncthing" ]]; then
  # syncthing
  yay -S --noconfirm syncthing
  yay -S --noconfirm syncthingtray
fi

if [[ " ${modules[@]} " =~ "plasma" ]]; then
  # konsole
  cp ./kde/ZshProfile.profile ~/.local/share/konsole
  cp ./kde/one_black.colorscheme ~/.local/share/konsole
  mkdir -p ~/.local/share/color-schemes
  cp ./kde/BreezeBlackCustom.colors ~/.local/share/color-schemes

  # screen locking change picture
  # window switcher meta
  # logout: confirm, end current session, start with manually saved
  # usermanager change picture
  # regional format us region, everything else österreich
  # power management anpassen
  # autostart: latte, syncthing, keepass

  # 144Hz
  # Add MaxFPS=144 to your ~/.config/kwinrc under [Compositing]
  # Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
  # about:config layout.frame_rate 144

  # intellij: material theme
  # kde theme:
  # colorscheme for konsole one dark in folder
  # colors -> brezze black custom
  # plasma theme breeze
  # window decorations breeze
  # icons candy icons
fi

if [[ " ${modules[@]} " =~ "latte-dock" ]]; then
  # latte addons
  sudo pacman -S --noconfirm cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons
  sh ./kde/latte_addons.sh

  # meta key latte menu
  kwriteconfig5 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"
  qdbus org.kde.KWin /KWin reconfigure

  # Hide titlebars when maximized (useful for topbar-layout)
  kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true
  qdbus org.kde.KWin /KWin reconfigure
fi

# deep-sleep:
# add mem_sleep_default=deep to the GRUB_CMDLINE_LINUX_DEFAULT entry in /etc/default/grub
