{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "deemix";
  service-version = "latest";
  service-port = "6595";

  deemix_arl = builtins.readFile "/run/secrets/docker/deemix_arl";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      deemix = {
        image = "registry.gitlab.com/bockiii/deemix-docker:${service-version}";
        ports = [
          "${service-port}:${service-port}"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          ARL = "${deemix_arl}";
        };
        volumes = [
          "${docker-data}/deemix/config:/config"
          "${docker-data}/navidrome/music:/downloads"
        ];
        extraOptions = [
          "--network=web"
        ];
      };
    };
  };
}
