#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
if [ -f ./config.sh ]; then
    source ./config.sh
else
   echo "Config file could not be found!"
   exit 1
fi

# Set the keyboard layout
loadkeys de-latin1

# Update the system clock
timedatectl set-ntp true

# Setup the disk and partitions
parted --script "${device}" -- mklabel gpt \
  mkpart primary fat32 1MiB 128MiB \
  set 1 esp on \
  mkpart primary ext4 128MiB 512MiB \
  set 2 boot on \
  mkpart primary ext4 512MiB 100%

# encrypt root partition
echo -n "${passphrase}" | cryptsetup -v luksFormat "${rootPartition}" -
echo -n "${passphrase}" | cryptsetup open "${rootPartition}" "${luksMapper}" -

# create logical volumes
pvcreate /dev/mapper/"${luksMapper}"
vgcreate "${volumeGroup}" /dev/mapper/"${luksMapper}"
lvcreate -l 100%FREE "${volumeGroup}" -n root

# create filesystems
mkfs.fat -F32 "${efiPartition}"
mkfs.ext4 "${bootPartition}"
mkfs.ext4 /dev/"${volumeGroup}"/root

# mount partitions
mount /dev/"${volumeGroup}"/root /mnt
mkdir -p /mnt/efi
mount "${efiPartition}" /mnt/efi
mkdir -p /mnt/boot
mount "${bootPartition}" /mnt/boot/

# Select the mirrors
cp pacman_mirrorlist /etc/pacman.d/mirrorlist

# Install the base packages
pacstrap /mnt base linux linux-firmware grub efibootmgr intel-ucode lvm2

# Configure the system
genfstab -U /mnt >> /mnt/etc/fstab

# install bootloader
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# setup boot for encrypted device
rootUUID=$(lsblk -dno UUID "${rootPartition}")
arch-chroot /mnt sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 filesystems fsck)/g' /etc/mkinitcpio.conf
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt sed -i 's,GRUB_CMDLINE_LINUX="",GRUB_CMDLINE_LINUX="cryptdevice=UUID='${rootUUID}':cryptlvm:allow-discards",g' /etc/default/grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# setup_system
arch-chroot mkdir -p /tmp/linux_setup
cp -R . /mnt/tmp/linux_setup
for module in ${modules[@]}
do
  arch-chroot /mnt chmod +x /tmp/linux_setup/modules/${module}.sh
  arch-chroot /mnt bin/bash /tmp/linux_setup/modules/${module}.sh
done
rm /mnt/tmp/*
