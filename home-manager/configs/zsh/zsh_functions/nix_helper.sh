#!/bin/sh

UPDATE_GITIGNORE=0

init_nix_shell() {
  for arg in "$@"
  do
    case $arg in
      -i|--ignore)
        UPDATE_GITIGNORE=1
        shift
        ;;
    esac
  done

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

}
