#!/bin/sh
# shellcheck disable=3010
# shellcheck disable=3037

# ------------------------------------- config -------------------------------------

device="/dev/vda"
passphrase="abcd"
hostname="virtual"

# ------------------------------------- functions ----------------------------------

if [[ $device =~ "nvme" ]]; then
  bootPartition="${device}p1"
  rootPartition="${device}p2"
else
  bootPartition="${device}1"
  rootPartition="${device}2"
fi

luksMapper="cryptroot"
unencryptedRoot="/dev/lvm/root"
swapSize=8192

# Setup the disk and partitions
parted --script "${device}" -- \
  mklabel gpt \
  mkpart ESP fat32 1MiB 512MiB \
  set 1 esp on \
  mkpart primary btrfs 512MiB 100%

# encrypt root partition
echo -n "${passphrase}" | cryptsetup -v luksFormat "${rootPartition}" -
echo -n "${passphrase}" | cryptsetup open "${rootPartition}" "${luksMapper}" -

# Create the lvm
pvcreate "/dev/mapper/${luksMapper}"
vgcreate lvm "/dev/mapper/${luksMapper}"
lvcreate --extents 100%FREE --name root lvm

# create filesystems
mkfs.fat -F 32 -n boot "${bootPartition}"
mkfs.btrfs -L nixos ${unencryptedRoot}

# create subvolumes
mkdir -p /mnt
mount "${unencryptedRoot}" /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/swap
umount /mnt

# Mount the partitions and subvolumes
mount -o compress=zstd,subvol=root $unencryptedRoot /mnt
mkdir -p /mnt/nix
mkdir -p /mnt/home
mkdir -p /mnt/swap
mount -o compress=zstd,subvol=home $unencryptedRoot /mnt/home
mount -o compress=zstd,noatime,subvol=nix $unencryptedRoot /mnt/nix
mount -o subvol=swap $unencryptedRoot /mnt/swap

# Create the swap file with copy-on-write and compression disabled:
truncate -s 0 /mnt/swap/swapfile
chattr +C /mnt/swap/swapfile
btrfs property set /mnt/swap compression none
dd if=/dev/zero of=/mnt/swap/swapfile bs=1M count=$swapSize
chmod 0600 /mnt/swap/swapfile
mkswap /mnt/swap/swapfile

# Mount the boot partition
mkdir /mnt/boot
mount $bootPartition /mnt/boot

# Generate the NixOS config
nixos-generate-config --root /mnt
cat /mnt/etc/nixos/hardware-configuration.nix > "../hosts/$hostname/hardware-configuration.nix"

deviceUUID=$(lsblk --fs | grep "crypto_LUKS" | awk '{print $4}')

echo "uuid of device: $deviceUUID"
