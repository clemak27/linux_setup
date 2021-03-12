#!/bin/zsh

set -uo pipefail

config="./modules.json"

function get_module() {
  cat $config | jq -rc ".modules[] | select(.name == \"$1\") | ."
}

get_module plasma

function get_packages() {
  cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .packages"
  packages=($(<$config jq -r ".modules[] | select(.name == \"$1\") | .packages | @sh"))
  for i in "${packages[@]}"
  do
    echo $i
    pacman -Ss $i
    echo "exists"
  done
}

get_packages plasma
