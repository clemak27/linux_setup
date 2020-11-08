#!/bin/zsh

# ------------------------ pacman ------------------------

# virtualization
# https://computingforgeeks.com/complete-installation-of-kvmqemu-and-virt-manager-on-arch-linux-and-manjaro/
pacman -S --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ovmf
pacman -S --noconfirm ebtables iptables
systemctl enable libvirtd.service

sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf

usermod -aG libvirt $user

# ------------------------ AUR ------------------------

# ------------------------ user ------------------------

# ------------------------ notes ------------------------
