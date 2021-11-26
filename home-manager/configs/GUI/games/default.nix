{ config, lib, pkgs, ... }:
{
  imports = [
    # TODO: add gzdoom, retroarch
    ./minecraft.nix
  ];

  xdg.configFile = {
    "MangoHud/MangoHud.conf".source = ./MangoHud.conf;
  };
}
