#!/bin/bash

# printer
pacman -S --noconfirm cups
systemctl enable org.cups.cupsd.service
