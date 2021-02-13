#!/bin/zsh

# ------------------------ KDE Plasma + i3 with gaps ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

# plasma
pacman -S --quiet --noprogressbar --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings

# kde-applications
pacman -S --quiet --noprogressbar --noconfirm ark dolphin ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks khelpcenter kio-extras ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect partitionmanager krita

# dolphin settings
cp /home/$user/Projects/linux_setup/plasma/dolphinrc /home/$user/.config/dolphinrc

# deactivate splash screen
cp /home/$user/Projects/linux_setup/plasma/ksplashrc /home/$user/.config/ksplashrc

# copy powermenu.sh
mkdir -p  /home/$user/.local/share/applications
cp  /home/$user/Projects/linux_setup/plasma/powermenu.sh.desktop /home/$user/.local/share/applications

# plasma + i3 session
cp /home/$user/Projects/linux_setup/plasma/plasma-i3.desktop /usr/share/xsessions
pacman -Rns --quiet --noprogressbar --noconfirm dunst

# plasma-specifics
pacman -S --quiet --noprogressbar --noconfirm plasma-browser-integration sshfs unrar
systemctl enable sddm

# latte-dock
pacman -S --quiet --noprogressbar --noconfirm latte-dock

# i3 gaps
pacman -S --quiet --noprogressbar --noconfirm i3-gaps

# wmctrl
pacman -S --quiet --noprogressbar --noconfirm wmctrl

# compositor
pacman -S --quiet --noprogressbar --noconfirm picom

# feh for wallpaper
pacman -S --quiet --noprogressbar --noconfirm feh

# ------------------------ AUR ------------------------

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
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
  'plasma5-applets-eventcalendar'
  'plasma5-applets-virtual-desktop-bar-git'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------

# logout: confirm, end current session, start with manually saved
# usermanager change picture
# regional format us region, everything else österreich
# power management anpassen
# autostart: latte, syncthing

# 144Hz
# Add MaxFPS=144 to your ~/.config/kwinrc under [Compositing]
# Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
# about:config layout.frame_rate 144

# intellij: material theme
# kde theme:
# colors -> breeze black custom
# plasma theme breeze
# window decorations breeze

# add .../rofi/combo.sh as custom shortcut
# use alt+space
