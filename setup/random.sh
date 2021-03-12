#!/bin/zsh

config="./modules.json"

function get_module() {
  cat $config | jq -rc ".modules[] | select(.name == \"$1\") | ."
}

# get_module plasma

function get_packages() {
  cat $config | jq -rc ".modules[] | select(.name == \"$1\") | .packages"
  packages=($(<$config jq -r ".modules[] | select(.name == \"$1\") | .packages | @sh"))
  echo $packages
}

get_packages plasma

