#!/bin/sh

function init_nix_shell() {

  echo ".envrc" >> .gitignore
  echo "shell.nix" >> .gitignore
  echo ".direnv" >> .gitignore

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

}
