#!/bin/sh

UPDATE_GITIGNORE=0

__init_shell() {
  if [ $UPDATE_GITIGNORE -eq 1 ]; then
    {
      echo ".direnv";
      echo ".envrc";
    } >> .gitignore
  fi

  nix flake new . -t github:nix-community/nix-direnv
  nvim flake.nix
  git add flake.nix
  direnv allow
}

__remove_shell() {
  rm -rf .direnv .envrc flake.nix flake.lock
}

nix-direnv() {
  for arg in "$@"
  do
    case $arg in
      -i|--ignore)
        UPDATE_GITIGNORE=1
        shift
        ;;
      init)
        __init_shell
        shift
        ;;
      remove)
        __remove_shell
        shift
        ;;
    esac
  done
}
