{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dotfiles;
in
{
  imports = [
    ./alacritty.nix
    ./ideavim.nix
    ./mpv.nix
  ];

}
