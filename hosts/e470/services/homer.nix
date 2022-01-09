{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "homer";
  service-version = "21.09.2";
  service-port = "8085";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      homer = {
        image = "b4bz/homer:${service-version}";
        ports = [
          "${service-port}:8080"
        ];
        environment = {
          UID = "1000";
          GID = "1000";
        };
        volumes = [
          "${docker-data}/homer:/www/assets"
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
          "--label=traefik.http.services.${service-name}-service.loadbalancer.server.port=8080"
        ];
      };
    };
  };
}
