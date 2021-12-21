{ config, pkgs, ... }:
let
  updateSystem = pkgs.writeShellScriptBin "update-system" ''
    sudo nixos-rebuild switch --upgrade
    nix-collect-garbage
    nvim -c 'PlugUpgrade | PlugUpdate | qa'
    tldr --update
  '';
in
{
  environment.systemPackages = with pkgs; [
    updateSystem
  ];
}
