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
pacman -S --quiet --noprogressbar --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-liberation

# default programs
pacman -S --quiet --noprogressbar --noconfirm firefox mpv keepassxc syncthing
ln -sf /home/$user/Projects/linux_setup/mpv/mpv.conf  /home/$user/.config/mpv/mpv.conf

# messaging
pacman -S --quiet --noprogressbar --noconfirm signal-desktop

# redshift
pacman -S --quiet --noprogressbar --noconfirm redshift
mkdir -p /home/$user/.config/redshift
ln -sf /home/$user/Projects/linux_setup/redshift/redshift.conf /home/$user/.config/redshift/redshift.conf

# videos
pacman -S --quiet --noprogressbar --noconfirm obs-studio kdenlive

# rofi
pacman -S --quiet --noprogressbar --noconfirm rofi rofi-calc dmenu

# kitty
pacman -S --quiet --noprogressbar --noconfirm kitty
mkdir -p /home/$user/.config/kitty
ln -sf /home/$user/Projects/linux_setup/kitty/kitty.conf /home/$user/.config/kitty/kitty.conf

# link Xresources
ln -sf /home/$user/Projects/linux_setup/DarkDev.Xresources /home/$user/.Xresources

# ------------------------ AUR ------------------------

# import spotify gpg key
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'scrcpy'
  'syncthingtray'
  'nerd-fonts-jetbrains-mono'
  'spotify'
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

# additional step for spicetify

chmod a+wr /opt/spotify
chmod a+wr /opt/spotify/Apps -R

# symlink spicetify stuff
mkdir -p /home/$user/.config/spicetify
mkdir -p /home/$user/.config/spicetify/Themes/Kustom

ln -sf /home/$user/Projects/linux_setup/spicetify/config.ini /home/$user/.config/spicetify/config.ini
ln -sf /home/$user/Projects/linux_setup/spicetify/color.ini /home/$user/.config/spicetify/Themes/Kustom/color.ini
ln -sf /home/$user/Projects/linux_setup/spicetify/user.css /home/$user/.config/spicetify/Themes/Kustom/user.css

# ------------------------ user ------------------------

# user-setup
declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  'export SPICETIFY_INSTALL=~/.spicetify-cli'
  'curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------

