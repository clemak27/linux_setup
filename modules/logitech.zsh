#!/bin/zsh

# ------------------------ logitech hardware tools ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

# logitech mouse customization

pacman -S --quiet --noprogressbar --noconfirm piper

# ------------------------ AUR ------------------------

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'g810-led-git'
  'headsetcontrol'
)

declare -r aur_packages
IFS=$SAVEIFS
for package in "${aur_packages[@]}"
do
  cd /home/aurBuilder
  git clone https://aur.archlinux.org/$package.git
  chmod -R g+w $package
  cd $package
  sudo -u nobody makepkg -sri --noconfirm
  cd /linux_setup
done


# ------------------------ user ------------------------

# ------------------------ notes ------------------------
