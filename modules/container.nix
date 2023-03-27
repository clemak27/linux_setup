{ config, pkgs, ... }:
{
  # virtualisation.podman = {
  #   enable = true;
  #   # Create a `docker` alias for podman, to use it as a drop-in replacement
  #   dockerCompat = true;
  # };
  virtualisation.docker = {
    enable = true;
  };

  users.users.clemens = {
    extraGroups = [ "docker" ];
  };
}
