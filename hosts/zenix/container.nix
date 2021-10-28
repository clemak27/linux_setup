{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  # spicy
  users.users.clemens.extraGroups = [ "docker" ];
}
