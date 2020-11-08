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


if [[ $gpu =~ "nvidia" ]]
then
  pacman -S --noconfirm dkms linux-headers nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
  pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
fi

# ------------------------ AUR ------------------------

# ------------------------ user ------------------------

# ------------------------ notes ------------------------
