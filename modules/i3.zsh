#!/bin/zsh

# ------------------------ i3 ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

# i3 gaps
pacman -S --quiet --noprogressbar --noconfirm i3-gaps i3blocks i3lock i3status i3status
mkdir -p /home/$user/.config/i3
ln -sf /home/$user/Projects/linux_setup/i3/config /home/$user/.config/i3/config

# polybar
ln -sf /home/$user/Projects/linux_setup/polybar/config /home/$user/.config/polybar/config

# compositor
pacman -S --quiet --noprogressbar --noconfirm picom
mkdir -p /home/$user/.config/picom
ln -sf /home/$user/Projects/linux_setup/picom/picom.conf /home/$user/.config/picom/picom.conf

pacman -Rns --quiet --noprogressbar --noconfirm dmenu

# feh for wallpaper
pacman -S --quiet --noprogressbar --noconfirm feh

# xss-lock
pacman -S --quiet --noprogressbar --noconfirm xss-lock

# notfications
pacman -S --quiet --noprogressbar --noconfirm dunst
mkdir -p /home/$user/.config/dunst
ln -sf /home/$user/Projects/linux_setup/dunst/dunstrc /home/$user/.config/dunst/dunstrc

# networking
pacman -S --quiet --noprogressbar --noconfirm networkmanager nm-connection-editor bmon network-manager-applet gnome-keyring libsecret seahorse

# ------------------------ AUR ------------------------

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'rofi-dmenu'
  'polybar'
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

declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  # kde
  ''
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------

