{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "navidrome";
  service-version = "0.47.5";
  service-port = "4533";

  navidrome_spotify_id = builtins.readFile "/run/secrets/docker/navidrome_spotify_id";
  navidrome_spotify_secret = builtins.readFile "/run/secrets/docker/navidrome_spotify_secret";
  navidrome_lastfm_apikey = builtins.readFile "/run/secrets/docker/navidrome_lastfm_apikey";
  navidrome_lastfm_secret = builtins.readFile "/run/secrets/docker/navidrome_lastfm_secret";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      navidrome = {
        image = "deluan/navidrome:${service-version}";
        environment = {
          ND_SPOTIFY_ID = "${navidrome_spotify_id}";
          ND_SPOTIFY_SECRET = "${navidrome_spotify_secret}";
          ND_LASTFM_APIKEY = "${navidrome_lastfm_apikey}";
          ND_LASTFM_SECRET = "${navidrome_lastfm_secret}";
          ND_ENABLECOVERANIMATION = "false";
        };
        ports = [
          "4533:4533"
        ];
        volumes = [
          "${docker-data}/${service-name}/data:/data"
          "${docker-data}/${service-name}/music:/music:ro"
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






