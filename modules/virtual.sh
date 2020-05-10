#!/bin/bash

cd "${0%/*}"
if [ -f ../config.sh ]; then
    source ../config.sh
else
   echo "Config file could not be found!"
   exit 1
fi

# virtualization
# https://computingforgeeks.com/complete-installation-of-kvmqemu-and-virt-manager-on-arch-linux-and-manjaro/
pacman -S --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ovmf
pacman -S --noconfirm ebtables iptables
systemctl enable libvirtd.service

sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf

sudo usermod -aG libvirt $user
