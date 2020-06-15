# https://zren.github.io/kde/

# latte addons
sudo pacman -S --noconfirm cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons

rm -rf ~/.local/share/plasma/plasmoids/org.kde.windowtitle
cd ~/Projects
git clone https://github.com/psifidotos/applet-window-title.git
cd applet-window-title
plasmapkg2 -i .

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-buttons.git
cd applet-window-buttons
sh install.sh

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-appmenu.git
cd applet-window-appmenu
sh install.sh

cd ~/Projects
rm -rf ./applet-window-appmenu ./applet-window-buttons ./applet-window-title

# meta key latte menu
kwriteconfig5 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"
qdbus org.kde.KWin /KWin reconfigure

# Hide titlebars when maximized (useful for topbar-layout)
kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true
qdbus org.kde.KWin /KWin reconfigure

# install event calendar widget
# screen locking change picture
# window switcher meta
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
# colorscheme for konsole one dark in folder
# colors -> brezze black custom
# plasma theme breeze alpha black
# window decorations breeze
# icons candy icons
