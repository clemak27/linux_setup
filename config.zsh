#!/bin/zsh

device="/dev/vda"
passphrase="abcd"
luksMapper="cryptroot"
volumeGroup="vg1"
hostname="virtual"
user="cle"
password="1234"
cpu="amd"
gpu="nvidia"

declare -a system_modules
system_modules=(
asdasdasd
#  plasma
#  gpu
#  gui
#  virtual
#  notebook
#  office
#  gaming
#  docker
#  development
#  logitech
)
declare -r system_modules

# ------------------------ map device type ------------------------

if [[ $device =~ "nvme" ]]
then
  efiPartition="${device}p1"
  bootPartition="${device}p2"
  rootPartition="${device}p3"
else
  efiPartition="${device}1"
  bootPartition="${device}2"
  rootPartition="${device}3"
fi

# ------------------------ checks ------------------------

for module in "${system_modules[@]}"
do
  if [ ! -f "./modules/$module.zsh" ]; then
     echo "Module file for "$module" could not be found!"
     exit 1
  fi
done