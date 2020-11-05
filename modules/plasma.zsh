#!/bin/zsh

# ------------------------ KDE Plasma ------------------------

# plasma
pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings

# kde-applications
pacman -S --noconfirm ark dolphin ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect partitionmanager krita

# kde-specifics
pacman -S --noconfirm plasma-browser-integration sshfs unrar
systemctl enable sddm

# kontact
pacman -S --noconfirm kontact kaddressbook korganizer kmail kmail-account-wizard

# latte-dock
pacman -S --noconfirm latte-dock

# user-setup
declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  'kde widgets'
  'yay -S plasma5-applets-eventcalendar'
  'yay -S plasma5-applets-window-appmenu plasma5-applets-window-buttons plasma5-applets-window-title'
  ''
  '# meta key latte menu'
  'kwriteconfig5 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"'
  'qdbus org.kde.KWin /KWin reconfigure'
  ''
  '# Hide titlebars when maximized (useful for topbar-layout)'
  'kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true'
  'qdbus org.kde.KWin /KWin reconfigure'
  ''
  '# screen locking change picture'
  '# logout: confirm, end current session, start with manually saved'
  '# usermanager change picture'
  '# regional format us region, everything else österreich'
  '# power management anpassen'
  '# autostart: latte, syncthing, keepass'
  ''
  '# 144Hz'
  '# Add MaxFPS=144 to your ~/.config/kwinrc under [Compositing]'
  '# Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup'
  '# about:config layout.frame_rate 144'
  ''
  '# intellij: material theme'
  '# kde theme:'
  '# colors -> breeze black custom'
  '# plasma theme breeze'
  '# window decorations breeze'
  ''
  '# add .../rofi/combo.sh as custom shortcut'
  '# use alt+space'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  echo "$task" >> setup_user.zsh
done
