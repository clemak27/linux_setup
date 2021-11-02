#!/bin/sh

# ------------------------------------- config -------------------------------------

device="/dev/sda"
passphrase="abcd"
password="1234"

hostName="zenix"
# user="clemens"
luksMapper="cryptroot"
volumeGroup="vg1"

# ------------------------------------- functions ----------------------------------

formatDevice() {
  if [[ $device =~ "nvme" ]]
  then
    bootPartition="${device}p1"
    rootPartition="${device}p2"
  else
    bootPartition="${device}1"
    rootPartition="${device}2"
  fi

  # Setup the disk and partitions
  parted --script "${device}" -- \
    mklabel gpt \
    mkpart ESP fat32 1MiB 512MiB \
    set 1 esp on \
    mkpart primary ext4 512MiB 100%

  # encrypt root partition
  echo -n "${passphrase}" | cryptsetup -v luksFormat "${rootPartition}" -
  echo -n "${passphrase}" | cryptsetup open "${rootPartition}" "${luksMapper}" -

  # create logical volumes
  pvcreate /dev/mapper/"${luksMapper}"
  vgcreate "${volumeGroup}" /dev/mapper/"${luksMapper}"
  lvcreate -l 100%FREE "${volumeGroup}" -n root

  # create filesystems
  mkfs.fat -F 32 -n boot "${bootPartition}"
  mkfs.ext4 -L nixos /dev/"${volumeGroup}"/root

  # mount partitions
  mount /dev/"${volumeGroup}"/root /mnt
  mkdir -p /mnt/boot
  mount "${bootPartition}" /mnt/boot/
}

# ------------------------------------- setup --------------------------------------

formatDevice
nixos-generate-config --root /mnt
