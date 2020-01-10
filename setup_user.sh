#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

#------

# https://zren.github.io/kde/

# are those two lines even needed?
localectl set-keymap de-latin1
localectl set-locale en_US.UTF-8
xdg-user-dirs-update

# dotfiles
mkdir -p ~/.config/nvim
cp dotfiles/vimrc ~/.config/nvim/init.vim

# plug-vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# pacman hooks
sudo mkdir -p /etc/pacman.d/hooks/
sudo cp other/grub.hook /etc/pacman.d/hooks/grub.hook

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
cp dotfiles/zshrc ~/.zshrc
chsh -s /usr/bin/zsh

# python dev packages
pip install jedi pylint --user

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
yay -S --noconfirm cava tty-clock steam-fonts
yay -S --noconfirm skypeforlinux-stable-bin

# mpv config
cp -r /usr/share/doc/mpv/ ~/.config/
sed -i 's/#autofit-larger=90%x90%/autofit-larger=40%x40%/g' ~/.config/mpv/mpv.conf
echo "" >> ~/.config/mpv/mpv.conf
echo 'ytdl-format="bestvideo[height<=?1080]+bestaudio/best"' >> ~/.config/mpv/mpv.conf
echo 'no-keepaspect-window' >> ~/.config/mpv/mpv.conf
echo 'x11-bypass-compositor=no' >> ~/.config/mpv/mpv.conf

# fix most gtk3 borders on kde
yay -S --noconfirm gtk3-nocsd-git

# gotop
yay -S --noconfirm gotop-bin

# syncthing
yay -S --noconfirm syncthingtray
yay -S --noconfirm syncthing

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

# Hide titlebars when maximized
kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true
qdbus org.kde.KWin /KWin reconfigure

# konsole
cp kde/TheProfile.profile ~/.local/share/konsole
cp kde/one_dark.colorscheme ~/.local/share/konsole

# screen locking bild rein
# window switcher meta
# logout: confirmen, end current session, start with manually saved
# usermanager bild ändern
# regional format us region, alles ändere österreich
# power management anpassen

# 144Hz
# Add MaxFPS=144 to your ~/.config/kwinrc
# Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
# about:config layout.frame_rate 144

# intellij: onedark
# kde theme:
    # Aritim dark
    # colorscheme for konsole one dark in folder
    # colors -> aritim dark unified
    # plasma theme aritim dark
    # window decorations sierra breeze
    # icons papirus-dark
