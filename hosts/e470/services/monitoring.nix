{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      prometheus =
        let
          service-name = "prometheus";
          service-version = "v2.32.1";
          service-port = "9090";
        in
        {
          image = "prom/prometheus:${service-version}";
          volumes = [
            "${docker-data}/${service-name}:/config"
          ];
          ports = [
            "${service-port}:${service-port}"
          ];
          cmd = [
            "--config.file=/config/config.yml"
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

      grafana =
        let
          service-name = "grafana";
          service-version = "8.3.3";
          service-port = "3001";
        in
        {
          image = "grafana/grafana:${service-version}";
          ports = [
            "${service-port}:3000"
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
            "--label=traefik.http.services.${service-name}-service.loadbalancer.server.port=3000"
          ];
        };
    };

    services.prometheus.exporters.node = {
      enable = true;
      enabledCollectors = [
        "logind"
        "systemd"
      ];
      disabledCollectors = [
        "textfile"
      ];
      openFirewall = true;
      firewallFilter = "-i br0 -p tcp -m tcp --dport 9100";
    };

  };
}
