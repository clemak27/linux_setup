#!/bin/zsh

config="./modules.json"

function get_module() {
  cat $config | jq -rc '.modules[] | select(.name == "plasma") | .'
}

get_module
