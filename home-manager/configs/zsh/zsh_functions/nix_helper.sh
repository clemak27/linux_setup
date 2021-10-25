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

update_nix() {
  echo "\e[1;36mUpdating nix channels\e[0m"
  nix-channel --update
  echo "\e[1;36mUpgrading nix-env\e[0m"
  nix-env --upgrade
  echo "\e[1;36mReloading home-manager config\e[0m"
  home-manager switch

  if [ -x $(which tldr) ] ; then
    echo "\e[1;36mUpdating tealdeer cache\e[0m"
    tldr --update
  fi

  if [ -x $(which nvim) ] ; then
    echo "\e[1;36mUpdating additional nvim tools\e[0m"
    update-nvim-dev
  fi
}
