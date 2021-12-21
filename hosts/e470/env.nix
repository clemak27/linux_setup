{ config, lib, pkgs, ... }:
let
    duckdns_token = builtins.readFile "/run/secrets/docker/duckdns_token";
    pihole_pw = builtins.readFile "/run/secrets/docker/pihole_pw";
    miniflux_admin_user = builtins.readFile "/run/secrets/docker/miniflux_admin_user";
    miniflux_admin_password = builtins.readFile "/run/secrets/docker/miniflux_admin_password";
    miniflux_db_user = builtins.readFile "/run/secrets/docker/miniflux_db_user";
    miniflux_db_password = builtins.readFile "/run/secrets/docker/miniflux_db_password";
    navidrome_spotify_id = builtins.readFile "/run/secrets/docker/navidrome_spotify_id";
    navidrome_spotify_secret = builtins.readFile "/run/secrets/docker/navidrome_spotify_secret";
    navidrome_lastfm_apikey = builtins.readFile "/run/secrets/docker/navidrome_lastfm_apikey";
    navidrome_lastfm_secret = builtins.readFile "/run/secrets/docker/navidrome_lastfm_secret";
    deemix_arl = builtins.readFile "/run/secrets/docker/deemix_arl";
in
{
  home.file.".env".text = ''
    DATA_DIR=/home/clemens/docker-data
    
    DUCKDNS_TOKEN=${duckdns_token}
    
    SYNCTHING_DOCKER_TAG=1.18.4
    
    PIHOLE_PW=${pihole_pw}
    
    TRAEFIK_DOCKER_TAG=2.5.4
    
    GITEA_DOCKER_TAG=1.15.6
    
    MINIFLUX_DOCKER_TAG=2.0.34
    MINIFLUX_ADMIN_USER=${miniflux_admin_user}
    MINIFLUX_ADMIN_PASSWORD=${miniflux_admin_password}
    
    POSTGRES_DOCKER_TAG=13
    MINIFLUX_DB_USER=${miniflux_db_user}
    MINIFLUX_DB_PASSWORD=${miniflux_db_password}
    
    NAVIDROME_DOCKER_TAG=0.47.0
    NAVIDROME_SPOTIFY_ID=${navidrome_spotify_id}
    NAVIDROME_SPOTIFY_SECRET=${navidrome_spotify_secret}
    NAVIDROME_LASTFM_APIKEY=${navidrome_lastfm_apikey}
    NAVIDROME_LASTFM_SECRET=${navidrome_lastfm_secret}
    NAVIDROME_ENABLECOVERANIMATION=false
    
    DEEMIX_DOCKER_TAG=latest
    DEEMIX_ARL=${deemix_arl}
  '';
}
