#!/bin/bash

set -uo pipefail

config="./modules.json"

function get_module() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | ."
  echo ""
}

function get_packages() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .packages"
  packages=($(<$config jq -r ".modules[] | select(.name == \"$1\") | .packages | @sh"))
  for i in "${packages[@]}"
  do
    # echo $i
    pacman -Ss $i
    # echo "exists"
  done
}

function get_commands() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .commands"
  commands=$(cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .commands | @sh")
  IFS="'" read -a pack <<< $commands

  for i in "${pack[@]}"
  do
    l=${#i}
    # shitty af
    if [[ $l -gt 3 ]]; then
      /bin/zsh -e -c $i
    fi
  done
}

get_module plasma
get_packages plasma
get_commands plasma
