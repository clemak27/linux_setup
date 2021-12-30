{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "jdownloader2";
  service-version = "v1.7.1";
  service-port = "5800";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      jdownloader2 = {
        image = "jlesage/jdownloader-2:${service-version}";
        ports = [
          "${service-port}:${service-port}"
        ];
        volumes = [
          "${docker-data}/jdownloader2/config:/config:rw"
          "${docker-data}/jdownloader2/downloads:/downloads"
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
