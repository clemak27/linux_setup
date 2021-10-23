{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
in
{
  imports = [
    ./node.nix
    ./java.nix
    ./go.nix
  ];
}
