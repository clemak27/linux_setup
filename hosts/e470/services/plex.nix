{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "plex";
  service-version = "1.25.4.5487-648a8f9f9";
  service-port = "32400";

  plex_claim = builtins.readFile "/run/secrets/docker/plex_claim";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      plex = {
        image = "plexinc/pms-docker:${service-version}";
        ports = [
          "${service-port}:${service-port}"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          VERSION = "docker";
          PLEX_CLAIM = "${plex_claim}";
        };
        volumes = [
          "${docker-data}/plex/config:/config"
          "${docker-data}/plex/movies:/data/movies"
          "${docker-data}/plex/series:/data/series"
          "${docker-data}/plex/transcode/temp:/transcode"
        ];
        extraOptions = [
          "--network=web"
          "--label=traefik.enable=true"
          "--label=traefik.http.routers.${service-name}-router.entrypoints=https"
          "--label=traefik.http.routers.${service-name}-router.rule=Host(`${service-name}.hemvist.duckdns.org`)"
          "--label=traefik.http.routers.${service-name}-router.tls=true"
          "--label=traefik.http.routers.${service-name}-router.tls.certresolver=letsEncrypt"
          # HTTP Services
          "--label=traefik.http.routers.${service-name}-router.service=${service-name}-service"
          "--label=traefik.http.services.${service-name}-service.loadbalancer.server.port=${service-port}"
        ];
      };
    };
  };
}
