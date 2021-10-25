#!/bin/zsh

function update-mirrorlist {
  echo "Updating pacman mirrorlist"
  sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bu
  echo "Creating new mirrorlist..."
  sudo reflector \
  --protocol https \
  --country Austria,Germany \
  --latest 10 \
  --age 12 \
  --sort rate \
  --save /etc/pacman.d/mirrorlist
  echo "mirrorlist updated!"
}

update-mirrorlist
