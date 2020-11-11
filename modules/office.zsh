#!/bin/zsh

# ------------------------ Office tools ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

# office
pacman -S --quiet --noprogressbar --noconfirm libreoffice-fresh libreoffice-fresh-de texlive-most

# printer
pacman -S --quiet --noprogressbar --noconfirm cups system-config-printer
systemctl enable org.cups.cupsd.service

# ------------------------ AUR ------------------------
# brother-dcpj572dw

# ------------------------ user ------------------------

# ------------------------ notes ------------------------
