#!/bin/zsh

# ------------------------ Notebook enhancements ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

# touchpad
pacman -S --quiet --noprogressbar --noconfirm xf86-input-libinput xf86-input-synaptics

# power management
pacman -S --quiet --noprogressbar --noconfirm tlp
systemctl enable tlp.service

# enable bluetooth
pacman -S --quiet --noprogressbar --noconfirm pulseaudio-bluetooth
systemctl enable bluetooth.service

# nvidia optimus
pacman -S --quiet --noprogressbar --noconfirm nvidia-prime

# ------------------------ AUR ------------------------

# ------------------------ user ------------------------

# ------------------------ notes ------------------------

# deep-sleep:
# add mem_sleep_default=deep to the GRUB_CMDLINE_LINUX_DEFAULT entry in /etc/default/grub
