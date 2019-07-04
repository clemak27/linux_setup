#!/bin/bash

# nvim config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
nvim -c q PluginInstall
nvim -c q call coc#util#install()
nvim -c q CocInstall coc-json coc-tsserver coc-html coc-css coc-yaml coc-python coc-snippets

# dotfiles
cp ~/.config/nvim/init.vim nvim_bu
cp ~/.bash_aliases bash_aliases_bu
cp ~/.bash_profile bash_profile_bu
cp ~/.bashrc bashrc_bu

mkdir ~/./config/nvim
cp dotfiles/vimrc ~/.config/nvim/init.vim
cp dotfiles/bash_aliases ~/.bash_aliases
cp dotfiles/bash_profile ~/.bash_profile
cp dotfiles/bashrc ~/.bashrc

cd ~
source .bash_aliases
source .bash_profile
source .bashrc

mkdir ~/Projects

#yay
cd ~/Projects
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# aur
yay -S --noconfirm vscodium-bin skypeforlinux-stable-bin syncthingtray

# git config
git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global credential.helper "cache --timeout=18000"

# vs code
vscodium --install-extension akamud.vscode-theme-onedark
vscodium --install-extension dakara.transformer
vscodium --install-extension eamodio.gitlens
vscodium --install-extension ms-python.python
vscodium --install-extension magicstack.magicpython
vscodium --install-extension visualstudioexptteam.vscodeintellicode
vscodium --install-extension james-yu.latex-workshop

# https://zren.github.io/kde/

cp kde/redshift.conf ~/.config/redshift.conf

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

# suru++
cd ~/Projects
wget -qO- https://raw.githubusercontent.com/gusbemacbe/suru-plus/master/install.sh | sh

# meta key latte menu
kwriteconfig5 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"
qdbus org.kde.KWin /KWin reconfigure

# screen locking bild rein
# window switcher meta
# logout: confirmen, end current session, start with empty
# usermanager bild ändern
# regional format us region, alles ändere österreich
# power management anpassen

# 144Hz
# Add MaxFPS=144 to your ~/.config/kwinrc
# Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
# about:config layout.frame_rate 144
