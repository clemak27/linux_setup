#!/bin/zsh

# ------------------------ GUI tools ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

# fonts
pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# default programs
pacman -S --noconfirm firefox mpv keepassxc

# messaging
pacman -S --noconfirm signal-desktop

# videos
pacman -S --noconfirm obs-studio kdenlive

# rofi
pacman -S --noconfirm rofi rofi-calc dmenu

# ------------------------ AUR ------------------------

# setup

cd /
mkdir /home/aurBuilder
chgrp nobody /home/aurBuilder
chmod g+ws /home/aurBuilder
setfacl -m u::rwx,g::rwx /home/aurBuilder
setfacl -d --set u::rwx,g::rwx,o::- /home/aurBuilder
usermod -d /home/aurBuilder nobody
echo '%nobody ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
cd /home/aurBuilder

# install packages

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'scrcpy'
  'spotify'
  'syncthing'
  'syncthingtray'
)

declare -r aur_packages
IFS=$SAVEIFS

for package in "${aur_packages[@]}"
do
  git clone https://aur.archlinux.org/$package.git
  chmod -R g+w $package
  cd $package
  sudo -u nobody makepkg -sri --noconfirm
  cd ..
done

# cleanup

sed -i '$d' /etc/sudoers
cd /linux_setup
usermod -d / nobody
rm -rf /home/aurBuilder

# additional steps

chmod a+wr /opt/spotify
chmod a+wr /opt/spotify/Apps -R

# ------------------------ user ------------------------

# user-setup
declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  'mkdir -p /home/$user/.config/rofi/themes'
  # rofi
  'ln -sf ~/Projects/linux_setup/rofi/custom.rasi ~/.config/rofi/themes/custom.rasi'
  # mpv
  'ln -sf ~/Projects/linux_setup/dotfiles/mpv.conf ~/.config/mpv/mpv.conf'
  # fonts
  'mkdir font'
  'cd font'
  'curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip'
  'unzip JetBrainsMono.zip'
  'mkdir jbm'
  'cp *Complete.ttf jbm'
  'rm jbm/JetBrains\ Mono\ Medium\ Med\ Ita\ Nerd\ Font\ Complete.ttf'
  'rm jbm/JetBrains\ Mono\ Medium\ Medium\ Nerd\ Font\ Complete.ttf'
  'rm jbm/JetBrains\ Mono\ ExtraBold\ ExtBd\ Nerd\ Font\ Complete.ttf'
  'rm jbm/JetBrains\ Mono\ ExtraBold\ ExBd\ I\ Nerd\ Font\ Complete.ttf'
  'cp -R jbm ~/.fonts'
  'cd ..'
  'rm -rf font'
#  'systemctl --user enable syncthing.service'
#  'systemctl --user start syncthing.service'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------

