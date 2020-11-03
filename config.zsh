#!/bin/zsh

device="/dev/nvme0n1"
passphrase="abcd"
password="1234"

# ------------------------ lazarus ------------------------

hostname="lazarus"
cpu="amd"
gpu="nvidia"

declare -a system_modules
system_modules=(
 plasma
 gpu
 gui
 virtual
 office
 gaming
 docker
 development
 logitech
#  notebook
)
declare -r system_modules

# ------------------------ common options ------------------------

user="clemens"
luksMapper="cryptroot"
volumeGroup="vg1"

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

if [ -z "$device" ]; then
  echo "device not set!"
  exit 1
fi

if [ -z "$passphrase" ]; then
  echo "passphrase not set!"
  exit 1
fi

if [ -z "$luksMapper" ]; then
  echo "luksMapper not set!"
  exit 1
fi

if [ -z "$volumeGroup" ]; then
  echo "volumeGroup not set!"
  exit 1
fi

if [ -z "$hostname" ]; then
  echo "hostname not set!"
  exit 1
fi

if [ -z "$user" ]; then
  echo "user not set!"
  exit 1
fi

if [ -z "$password" ]; then
  echo "password not set!"
  exit 1
fi

if [ -z "$cpu" ]; then
  echo "cpu not set!"
  exit 1
fi

if [ "$cpu" != "intel" ] | [ "$cpu" != "amd" ]; then
  echo "cpu set to unknown value!"
  exit 1
fi

if [ -z "$gpu" ]; then
  echo "gpu not set!"
  exit 1
fi

if [ "$gpu" != "nvidia" ] | [ "$gpu" != "amd" ]; then
  echo "gpu set to unknown value!"
  exit 1
fi
