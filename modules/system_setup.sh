#!/bin/zsh

packages=($((jq -rc '.plasma | .packages | @sh' system_config.json) | tr -d \'))

echo "Array size: " ${#packages[@]}

for i in "${packages[@]}"
do
  echo "Installing $i"
  pacman -S --noconfirm $i
done

user_packages=($((jq -rc '.plasma | .user_packages | @sh' system_config.json) | tr -d \'))

echo "Array size: " ${#user_packages[@]}

for i in "${user_packages[@]}"
do
  echo "Adding $i to user_setup"
  echo "yay -S $i" >> user_setup.sh
done
