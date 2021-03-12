#!/bin/zsh

# ------------------------ Office tools ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

# office
pacman -S --quiet --noprogressbar --noconfirm libreoffice-fresh libreoffice-fresh-de texlive-most

# printer
pacman -S --quiet --noprogressbar --noconfirm cups system-config-printer
systemctl enable org.cups.cupsd.service

# ------------------------ AUR ------------------------
# brother-dcpj572dw

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'pandoc-bin'
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
