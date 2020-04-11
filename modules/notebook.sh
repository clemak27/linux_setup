#!/bin/bash

# touchpad
pacman -S --noconfirm xf86-input-libinput xf86-input-synaptics

# power management
pacman -S --noconfirm tlp
systemctl enable tlp.service
