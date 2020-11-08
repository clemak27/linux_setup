#!/bin/zsh

# ------------------------ GPU drivers ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------

pacman -S --noconfirm mesa


if [ $gpu = "nvidia" ]; then
  pacman -S --noconfirm dkms linux-headers nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
  pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
fi

if (($system_modules[(Ie)"notebook"])) && [ $gpu = "nvidia" ]; then
  pacman -S --noconfirm nvidia-prime
fi

# ------------------------ AUR ------------------------

# ------------------------ user ------------------------

# ------------------------ notes ------------------------
