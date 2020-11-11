#!/bin/zsh

# ------------------------ KDE Plasma ------------------------

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
pacman -S --quiet --noprogressbar --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings

# kde-applications
pacman -S --quiet --noprogressbar --noconfirm ark dolphin ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect partitionmanager krita

# kde-specifics
pacman -S --quiet --noprogressbar --noconfirm plasma-browser-integration sshfs unrar
systemctl enable sddm

# kontact
pacman -S --quiet --noprogressbar --noconfirm kontact kaddressbook korganizer kmail kmail-account-wizard

# latte-dock
pacman -S --quiet --noprogressbar --noconfirm latte-dock

# ------------------------ AUR ------------------------

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'plasma5-applets-eventcalendar'
  'plasma5-applets-window-appmenu'
  'plasma5-applets-window-buttons'
  'plasma5-applets-window-title'
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
  'mkdir -p ~/.local/share/color-schemes'
  'mkdir -p ~/.config/latte'
  'cp ~/.config/latte/Default.layout.latte ~/.config/latte/Default.bu.layout.latte'
  'ln -sf ~/Projects/linux_setup/kde/ZshProfile.profile ~/.local/share/konsole/ZshProfile.profile'
  'ln -sf ~/Projects/linux_setup/kde/kustom.colorscheme ~/.local/share/konsole/kustom.colorscheme'
  'ln -sf ~/Projects/linux_setup/kde/BreezeDarkCustom.colors ~/.local/share/color-schemes/BreezeDarkCustom.colors'
  'ln -sf ~/Projects/linux_setup/kde/united.layout.latte ~/.config/latte/Default.layout.latte'
  # Hide titlebars when maximized
  'kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true' 
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------

# screen locking change picture
# logout: confirm, end current session, start with manually saved
# usermanager change picture
# regional format us region, everything else österreich
# power management anpassen
# autostart: latte, syncthing, keepass

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
