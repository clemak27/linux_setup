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
pacman -S --quiet --noprogressbar --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# default programs
pacman -S --quiet --noprogressbar --noconfirm firefox mpv keepassxc

# messaging
pacman -S --quiet --noprogressbar --noconfirm signal-desktop

# videos
pacman -S --quiet --noprogressbar --noconfirm obs-studio kdenlive

# rofi
pacman -S --quiet --noprogressbar --noconfirm rofi rofi-calc dmenu

# JetBrainsMono
mkdir font
cd font
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
mkdir jbm
cp *Complete.ttf jbm
rm jbm/JetBrains\ Mono\ Medium\ Med\ Ita\ Nerd\ Font\ Complete.ttf
rm jbm/JetBrains\ Mono\ Medium\ Medium\ Nerd\ Font\ Complete.ttf
rm jbm/JetBrains\ Mono\ ExtraBold\ ExtBd\ Nerd\ Font\ Complete.ttf
rm jbm/JetBrains\ Mono\ ExtraBold\ ExBd\ I\ Nerd\ Font\ Complete.ttf
cp -R jbm /home/$user/.fonts
cd ..
rm -rf font

# ------------------------ AUR ------------------------

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
  cd /home/aurBuilder
  git clone https://aur.archlinux.org/$package.git
  chmod -R g+w $package
  cd $package
  sudo -u nobody makepkg -sri --noconfirm
  cd /linux_setup
done

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

