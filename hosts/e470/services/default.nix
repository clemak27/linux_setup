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

# systemd.services.init-docker-network-backend = {
#   description = "Create backend network.";
#   after = [ "network.target" ];
#   wantedBy = [ "multi-user.target" ];
  
#   serviceConfig.Type = "oneshot";
#    script =
#      let
#        dockercli = "${config.virtualisation.docker.package}/bin/docker";
#      in ''
#        # Put a true at the end to prevent getting non-zero return code, which will
#        # crash the whole service.
#        check=$(${dockercli} network ls | grep "backend" || true)
#        if [ -z "$check" ]; then
#          ${dockercli} network create backend --internal
#        else
#          echo "backend network already exists in docker"
#        fi
#      '';
# };

}
