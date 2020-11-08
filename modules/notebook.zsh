#!/bin/zsh

# ------------------------ pacman ------------------------

# touchpad
pacman -S --noconfirm xf86-input-libinput xf86-input-synaptics

# power management
pacman -S --noconfirm tlp
systemctl enable tlp.service

# enable bluetooth
pacman -S --noconfirm pulseaudio-bluetooth
systemctl enable bluetooth.service

# ------------------------ AUR ------------------------

# ------------------------ user ------------------------

# ------------------------ notes ------------------------

# deep-sleep:
# add mem_sleep_default=deep to the GRUB_CMDLINE_LINUX_DEFAULT entry in /etc/default/grub
