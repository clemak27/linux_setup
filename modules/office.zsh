#!/bin/zsh

# ------------------------ pacman ------------------------

# office
pacman -S --noconfirm libreoffice-fresh libreoffice-fresh-de texlive-most

# printer
pacman -S --noconfirm cups system-config-printer
systemctl enable org.cups.cupsd.service

# ------------------------ AUR ------------------------
# brother-dcpj572dw

# ------------------------ user ------------------------

# ------------------------ notes ------------------------
