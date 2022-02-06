{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";
  torrent-path = "/home/clemens/data/docker/torrents";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      transmission =
        let
          service-name = "transmission";
          service-version = "version-3.00-r2";
          service-port = "9091";
        in
        {
          image = "linuxserver/transmission:${service-version}";
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Europe/vienna";
          };
          volumes = [
            "${docker-data}/${service-name}:/config"
            "${torrent-path}:/downloads"
          ];
          ports = [
            "${service-port}:${service-port}"
            "49153:49153"
            "49153:49153/udp"
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
      jackett =
        let
          service-name = "jackett";
          service-version = "0.20.514";
          service-port = "9117";
        in
        {
          image = "linuxserver/jackett:${service-version}";
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Europe/vienna";
          };
          volumes = [
            "${docker-data}/${service-name}:/config"
            "${torrent-path}/completed:/downloads"
          ];
          ports = [
            "${service-port}:${service-port}"
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
      sonarr =
        let
          service-name = "sonarr";
          service-version = "3.0.6";
          service-port = "8989";
        in
        {
          image = "linuxserver/sonarr:${service-version}";
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Europe/vienna";
          };
          volumes = [
            "${docker-data}/${service-name}:/config"
            "${torrent-path}:/downloads"
            "${docker-data}/plex/series:/downloads/series"
          ];
          ports = [
            "${service-port}:${service-port}"
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

      radarr =
        let
          service-name = "radarr";
          service-version = "4.0.4";
          service-port = "7878";
        in
        {
          image = "linuxserver/radarr:${service-version}";
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Europe/vienna";
          };
          volumes = [
            "${docker-data}/${service-name}:/config"
            "${torrent-path}:/downloads"
            "${docker-data}/plex/movies:/downloads/movies"
          ];
          ports = [
            "${service-port}:${service-port}"
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
