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
  local packages=$(cat $config | jq -r ".modules[] | select(.name == \"$1\") | .packages | @sh")
  local pack=$(echo $packages | sed -e "s,',,g")
  echo "installing: $pack"
  pacman -S --quiet --noprogressbar --noconfirm $pack
}

function execute_commands() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .commands"
  local commands=$(cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .commands | @sh")
  IFS="'" read -a cmd <<< $commands

  for i in "${cmd[@]}"
  do
    l=${#i}
    # shitty af
    if [[ $l -gt 3 ]]; then
      rp="${i//\$user/$user}"
      rp="${i//\;/\'}"
      echo "executing: $rp"
      /bin/zsh -e -c "$rp"
    fi
  done
  unset cmd
}

function install_aur_packages() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .aur"
  local packages=($(<$config jq -r ".modules[] | select(.name == \"$1\") | .aur | @sh"))
  local pack=$(echo $packages | sed -e "s,',,g")

  for package in "${pack[@]}"
  do
    echo "installing aur package: $package"
    svdp=$(pwd)
    cd /home/aurBuilder
    git clone https://aur.archlinux.org/$package.git
    chmod -R g+w $package
    cd $package
    sudo -u nobody makepkg -sri --noconfirm
    cd $svdp
    unset svdp
  done
}

function execute_user_commands() {
  # cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .user_commands"
  local commands=$(cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .user_commands | @sh")
  IFS="'" read -a cmd <<< $commands

  for i in "${cmd[@]}"
  do
    l=${#i}
    # shitty af
    if [[ $l -gt 3 ]]; then
      rp="${i//\$user/$user}"
      rp="${i//\;/\'}"
      echo "executing: $rp"
      su - $user -c $rp
    fi
  done
  unset cmd
}

function setup_module() {

  if [ "$#" -ne 1 ]; then
    echo "missing module name!"
    return 1
  fi

  echo "Setting up module $1"
  install_packages $1
  execute_commands $1
  install_aur_packages $1
  execute_user_commands $1
}

setup_module $1
