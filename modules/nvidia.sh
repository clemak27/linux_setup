#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

pacman -S --noconfirm dkms linux-headers linux-lts-headers nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
