{ config, pkgs, ... }:
let
  updateSystem = pkgs.writeShellScriptBin "update-system" ''
    cd $HOME/Projects/linux_setup
    nix flake update
    git add flake.nix flake.lock
    git commit -m "chore(flake): Update $(date -I)"
    sudo nixos-rebuild switch --flake . --impure
    nix-collect-garbage
    nix-store --optimise
    tldr --update
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    cd -
  '';
in
{
  environment.systemPackages = with pkgs; [
    updateSystem
  ];
}
