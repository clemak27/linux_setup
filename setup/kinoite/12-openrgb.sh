#!/bin/bash

set -xueo pipefail

if [ "$HOSTNAME" = "maxwell" ]; then
  mkdir -p "$HOME/.local/share/applications"
  flatpak install -y flathub org.openrgb.OpenRGB
  curl -LO "https://openrgb.org/releases/release_0.9/60-openrgb.rules"
  sudo mv 60-openrgb.rules /etc/udev/rules.d/
  sudo restorecon /etc/udev/rules.d/60-openrgb.rules
  sudo udevadm control --reload-rules
  sudo udevadm trigger

  cat << EOF > "$HOME/.config/autostart/openrgb.sh"
#!/bin/bash

/usr/bin/flatpak run org.openrgb.OpenRGB -p default
EOF

  chmod +x "$HOME/.config/autostart/openrgb.sh"

  mkdir -p "$HOME/.config/autostart"
  cat << EOF > "$HOME/.config/autostart/openrgb.sh.desktop"
[Desktop Entry]
Exec=$HOME/.config/autostart/openrgb.sh
Icon=application-x-shellscript
Name=openrgb.sh
Type=Application
X-KDE-AutostartScript=true
EOF
fi
