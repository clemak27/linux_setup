#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# touchpad
pacman -S --noconfirm xf86-input-libinput xf86-input-synaptics

# power management
pacman -S --noconfirm tlp
systemctl enable tlp.service

# enable bluetooth
pacman -S --noconfirm pulseaudio-bluetooth
systemctl enable bluetooth.service

# deep-sleep:
# add mem_sleep_default=deep to the GRUB_CMDLINE_LINUX_DEFAULT entry in /etc/default/grub
