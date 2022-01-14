{ config, pkgs, ... }:
{
  imports = [
    ./deemix.nix
    ./gitea.nix
    ./homer.nix
    ./miniflux.nix
    ./monitoring.nix
    ./navidrome.nix
    ./pihole.nix
    ./plex.nix
    ./syncthing.nix
    ./torrents.nix
    ./traefik.nix
  ];

  virtualisation.oci-containers = {
    backend = "docker";
  };
}
