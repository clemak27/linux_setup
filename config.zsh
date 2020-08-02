#!/bin/zsh

device="/dev/vda"
passphrase="abcd"
luksMapper="cryptroot"
volumeGroup="vg1"
hostname="virtual"
user="cle"
password="1234"
cpu="amd"

declare -a system_modules
system_modules=(
  plasma
#  plasma
  gui
#  mesa
#  nvidia
#  nvidia-prime
#  virtual
#  notebook
#  office
#  printer
#  gaming
#  docker
#  java
#  python
#  go
#  rust
#  syncthing
#  logitech
)
declare -r system_modules

# map device type

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

# ------------------------ modules ------------------------

declare -A setup_commands
declare -A user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# ------------------------ plasma ------------------------

declare -a plasma_commands
plasma_commands=(
    'echo "asdf"'
    ''
)
declare -r plasma_commands
setup_commands[plasma]=$plasma_commands

declare -a plasma_user_commands
plasma_user_commands=(
    'echo "aaaaaaaaaaaaa"'
)
declare -r plasma_user_commands
user_commands[plasma]=$plasma_user_commands

# ------------------------ gui ------------------------

declare -a gui_commands
gui_commands=(
    'echo "asdasd"'
)
declare -r gui_commands
setup_commands[gui]=$gui_commands

declare -a gui_user_commands
gui_user_commands=(
)
declare -r gui_user_commands
user_commands[gui]=$gui_user_commands

# ------------------------ cleanup ------------------------
IFS=$SAVEIFS