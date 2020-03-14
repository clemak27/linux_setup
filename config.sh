#!/bin/bash

device="/dev/vda"
passphrase="abcd"
luksPartition="cryptroot"
volumeGroup="vg1"
hostname="virtual"
user="cle"
password="1234"

#---------------------------

efiGroup="${device}1"
bootGroup="${device}2"
rootGroup="${device}3"

