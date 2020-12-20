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

# kitty
pacman -S --quiet --noprogressbar --noconfirm kitty
mkdir -p /home/$user/.config/kitty
ln -sf /home/$user/Projects/linux_setup/kitty/kitty.conf /home/$user/.config/kitty/kitty.conf
cp /home/$user/Projects/linux_setup/kitty/scroll_mark.py /home/$user/.config/kitty
cp /home/$user/Projects/linux_setup/kitty/search.py /home/$user/.config/kitty

# ------------------------ AUR ------------------------

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  ''
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
  'mkdir -p ~/.local/share/konsole'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------

