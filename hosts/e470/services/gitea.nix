{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "gitea";
  service-version = "1.16.1";
  service-port = "3000";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      gitea = {
        image = "gitea/gitea:${service-version}";
        ports = [
          "${service-port}:${service-port}"
        ];
        volumes = [
          "${docker-data}/${service-name}:/data"
          "/etc/timezone:/etc/timezone:ro"
          "/etc/localtime:/etc/localtime:ro"
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
          # SSH access
          "--label=traefik.tcp.routers.gitea-ssh.rule=HostSNI(`*`)"
          "--label=traefik.tcp.routers.gitea-ssh.entrypoints=ssh"
          "--label=traefik.tcp.routers.gitea-ssh.service=gitea-ssh-service"
          "--label=traefik.tcp.services.gitea-ssh-service.loadbalancer.server.port=22"
        ];
      };
    };
  };
}
