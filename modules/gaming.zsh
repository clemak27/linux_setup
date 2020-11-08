#!/bin/zsh

# ------------------------ Gaming ------------------------

# gaming

pacman -S --noconfirm wine-staging lutris steam discord 
pacman -S --noconfirm retroarch retroarch-assets-xmb

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
  'steam-fonts'
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

# ------------------------ user ------------------------

# ------------------------ Notes ------------------------
