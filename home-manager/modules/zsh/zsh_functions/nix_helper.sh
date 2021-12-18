#!/bin/sh

UPDATE_GITIGNORE=0

__init_shell() {
  if [ $UPDATE_GITIGNORE -eq 1 ]; then
    {
      echo ".direnv";
      echo ".envrc";
      echo "shell.nix";
    } >> .gitignore
  fi

  echo "use_nix" > .envrc

  cat << EOF > ./shell.nix
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
  # insert derivates here
  nativeBuildInputs = [
  pkgs.buildPackages.nodejs-12_x
  ];
}
EOF

  nvim shell.nix

  direnv allow
}

__remove_shell() {
 rm -rf .direnv .envrc shell.nix
}

nix_shell() {
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
