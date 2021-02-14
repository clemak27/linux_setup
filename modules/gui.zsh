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

# pipewire
pacman -S --quiet --noprogressbar --noconfirm pipewire pipewire-pulse pipewire-jack pipewire-alsa

# default programs
pacman -S --quiet --noprogressbar --noconfirm firefox mpv keepassxc syncthing

# messaging
pacman -S --quiet --noprogressbar --noconfirm signal-desktop

# redshift
pacman -S --quiet --noprogressbar --noconfirm redshift

# videos
pacman -S --quiet --noprogressbar --noconfirm obs-studio kdenlive

# rofi
pacman -S --quiet --noprogressbar --noconfirm rofi rofi-calc dmenu

# kitty
pacman -S --quiet --noprogressbar --noconfirm kitty

# spotifyd
pacman -S --quiet --noprogressbar --noconfirm spotifyd
mkdir -p /home/$user/.cache/spotifyd

# ------------------------ AUR ------------------------

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'scrcpy'
  'syncthingtray'
  'nerd-fonts-jetbrains-mono'
  'spotify-tui-bin'
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

# spotify tui autocompletions
mkdir /home/$user/.oh-my-zsh/custom/plugins/spt
echo "compdef _spt spt" > /home/$user/.oh-my-zsh/custom/plugins/spt/spt.plugin.zsh
spt --completions zsh > /home/$user/.oh-my-zsh/custom/plugins/spt/_spt

# ------------------------ user ------------------------

# user-setup
declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  ''
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------

