#!/bin/bash

device="/dev/vda"
passphrase="abcd"
luksMapper="cryptroot"
volumeGroup="vg1"
hostname="virtual"
user="cle"
password="1234"
modules=(core)
cpu="amd"
# modules=(core plasma gui mesa nvidia nvidia-prime virtual notebook office printer gaming docker java python go rust syncthing logitech)

#---------------------------

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
