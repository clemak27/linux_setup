#!/bin/zsh

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
if [ -f ./config.zsh ]; then
    source ./config.zsh
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

if [ $cpu == "amd" ]; then
  pacstrap /mnt base linux linux-firmware grub efibootmgr amd-ucode lvm2 base-devel
else
  pacstrap /mnt base linux linux-firmware grub efibootmgr intel-ucode lvm2 base-devel
fi

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

# setup system
cp -R . /mnt/linux_setup
arch-chroot /mnt chmod +x /linux_setup/setup_system.zsh
arch-chroot /mnt /bin/zsh /linux_setup/setup_system.zsh

# prepare user setup
arch-chroot /mnt cp /linux_setup/setup_user.sh /home/${user}
arch-chroot /mnt chmod +x /home/${user}/setup_user.sh
arch-chroot /mnt chown -R ${user}:${user} /home/${user}

rm -rf /mnt/linux_setup
