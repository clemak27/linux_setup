#!/bin/bash

device="/dev/vda"
passphrase="abcd"
luksPartition="cryptroot"
volumeGroup="vg1"
hostname="virtual"
user="cle"
password="1234"

#---------------------------

efiPartition="${device}1"
bootPartition="${device}2"
rootPartition="${device}3"

