#!/bin/zsh

packages=($((jq -rc '.plasma | .packages | @sh' system_config.json) | tr -d \'))

echo "Array size: " ${#packages[@]}

for i in "${packages[@]}"
do
  echo "Installing $i"
  pacman -S --noconfirm $i
done

commands=($((jq -rc '.plasma | .commands| @sh' system_config.json)))

echo "Array size: " ${#commands[@]}

for i in "${commands[@]}"
do
  echo "Executing $i"
  $i
done
