#!/bin/bash

set -uo pipefail

config="./modules.json"

# ------------------------ Load config -----------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ define functions ------------------------

function print_module_json() {
  cat $config | jq -rc ".modules[] | select(.name == \"$1\") | ."
}

function install_packages() {
  packages=$(cat $config | jq -r ".modules[] | select(.name == \"$1\") | .packages | @sh")
  pack=$(echo $packages | sed -e "s,',,g")
  echo "installing: $pack"
}

function execute_commands() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .commands"
  commands=$(cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .commands | @sh")
  IFS="'" read -a pack <<< $commands

  for i in "${pack[@]}"
  do
    l=${#i}
    # shitty af
    if [[ $l -gt 3 ]]; then
      rp="${i//\$user/$user}"
      echo "executing: $rp"
      # /bin/zsh -e -c "$rp"
    fi
  done
}

function install_aur() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .aur"
  packages=($(<$config jq -r ".modules[] | select(.name == \"$1\") | .aur | @sh"))
  for i in "${packages[@]}"
  do
    echo "installing aur package: $i"
  done
}

function execute_user_commands() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .user_commands"
  commands=$(cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .user_commands | @sh")
  IFS="'" read -a pack <<< $commands

  for i in "${pack[@]}"
  do
    l=${#i}
    # shitty af
    if [[ $l -gt 3 ]]; then
      rp="${i//\$user/$user}"
      echo "executing: $rp"
      # /bin/zsh -e -c "$rp"
    fi
  done
}

function setup_module() {

  if [ "$#" -ne 1 ]; then
    echo "missing module name!"
    return 1
  fi

  echo "Setting up module $1"
}

setup_module desktop_environment
