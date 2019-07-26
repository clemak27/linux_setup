#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

#------

# https://zren.github.io/kde/

localectl set-keymap de
xdg-user-dirs-update

# dotfiles
cp ~/.bash_aliases bash_aliases_bu
cp ~/.bash_profile bash_profile_bu
cp ~/.bashrc bashrc_bu

mkdir -p ~/.config/nvim
cp dotfiles/vimrc ~/.config/nvim/init.vim
cp dotfiles/bash_aliases ~/.bash_aliases
cp dotfiles/bash_profile ~/.bash_profile
cp dotfiles/bashrc ~/.bashrc

sudo mkdir -p /etc/pacman.d/hooks/
sudo cp other/grub.hook /etc/pacman.d/hooks/grub.hook

cd ~
source .bash_aliases
source .bash_profile
source .bashrc

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
source .bashrc
nvm install --lts

# nvim config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
nvim -c PluginInstall -c q -c q!
nvim -c "call coc#util#install()" -c q!
nvim -c "CocInstall coc-json coc-tsserver coc-html coc-css coc-yaml coc-python coc-snippets"

# git config
git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global credential.helper "cache --timeout=18000"

mkdir ~/Projects

#yay
cd ~/Projects
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# aur
pacman -S --noconfirm automake autoconf
yay -S --noconfirm cava tty-clock steam-fonts
yay -S --noconfirm skypeforlinux-stable-bin

# syncthing deamon
systemctl --user enable syncthing.service

# mpv config
cp -r /usr/share/doc/mpv/ ~/.config/
sed -i 's/#autofit-larger=90%x90%/autofit-larger=40%x40%/g' ~/.config/mpv/mpv.conf
echo "" >> ~/.config/mpv/mpv.conf
echo 'ytdl-format="bestvideo[height<=?1080]+bestaudio/best"' >> ~/.config/mpv/mpv.conf

## kde

cp kde/redshift.conf ~/.config/redshift.conf
yay -S --noconfirm syncthingtray gtk3-nocsd-git

# latte addons
sudo pacman -S --noconfirm cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-title.git
cd applet-window-title
plasmapkg2 -i .

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-buttons.git
cd applet-window-buttons
sh install.sh

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-appmenu.git
cd applet-window-appmenu
sh install.sh

# meta key latte menu
kwriteconfig5 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"
qdbus org.kde.KWin /KWin reconfigure

# suru++
cd ~/Projects
wget -qO- https://raw.githubusercontent.com/gusbemacbe/suru-plus/master/install.sh | sh

# screen locking bild rein
# window switcher meta
# logout: confirmen, end current session, start with empty
# usermanager bild ändern
# regional format us region, alles ändere österreich
# power management anpassen
# redshift zu autostart

# 144Hz
# Add MaxFPS=144 to your ~/.config/kwinrc
# Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
# about:config layout.frame_rate 144


## gnome

sudo pacman -S tilix evolution kvantum-qt5

# gnome extensions
sudo pacman -S install gnome-tweak-tool curl
chmod a+x ./gnome/gnome-shell-extension-installer.sh
./gnome/gnome-shell-extension-installer.sh 15 # alternatetab
./gnome/gnome-shell-extension-installer.sh 615 # appindicator-support
./gnome/gnome-shell-extension-installer.sh 307 # dash-to-dock
./gnome/gnome-shell-extension-installer.sh 19 # user-themes
./gnome/gnome-shell-extension-installer.sh 943 # Workspace Scroll
./gnome/gnome-shell-extension-installer.sh 1319 # GSConnect
./gnome/gnome-shell-extension-installer.sh 1011 # dynamic panel transparency
mkdir -p ~/.config/tilix/schemes/
cp gnome/one-dark.json ~/.config/tilix/schemes/
