#!/bin/bash

set -uo pipefail

config="./modules.json"

function get_module() {
  cat $config | jq -rc ".modules[] | select(.name == \"$1\") | ."
}

function get_packages() {
  packages=($(<$config jq -r ".modules[] | select(.name == \"$1\") | .packages | @sh"))
  for i in "${packages[@]}"
  do
    echo "package: $i"
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
      echo "executing: $i"
      # /bin/zsh -e -c "$i"
    fi
  done
}

function get_aur() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .aur"
  packages=($(<$config jq -r ".modules[] | select(.name == \"$1\") | .aur | @sh"))
  for i in "${packages[@]}"
  do
    echo "aur package: $i"
  done
}

function get_user_commands() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .user_commands"
  commands=$(cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .user_commands | @sh")
  IFS="'" read -a pack <<< $commands

  for i in "${pack[@]}"
  do
    l=${#i}
    # shitty af
    if [[ $l -gt 3 ]]; then
      echo "executing: $i"
      /bin/zsh -e -c "$i"
    fi
  done
}

# get_module plasma
get_packages plasma
get_commands plasma
get_aur plasma
get_user_commands plasma
