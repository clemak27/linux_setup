#!/bin/bash

device="/dev/vda"
passphrase="abcd"
luksPartition="cryptroot"
volumeGroup="vg1"
hostname="virtual"
user="cle"
password="1234"

#---------------------------

if [[ $device =~ "nvme" ]]
then
  efiVolume="${device}p1"
  bootVolume="${device}p2"
  rootVolume="${device}p3"
else
  efiVolume="${device}1"
  bootVolume="${device}2"
  rootVolume="${device}3"
fi



