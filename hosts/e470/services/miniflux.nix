{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "miniflux";
  service-version = "2.0.35";
  service-port = "8081";

  miniflux_admin_user = builtins.readFile "/run/secrets/docker/miniflux_admin_user";
  miniflux_admin_password = builtins.readFile "/run/secrets/docker/miniflux_admin_password";
  miniflux_db_user = builtins.readFile "/run/secrets/docker/miniflux_db_user";
  miniflux_db_password = builtins.readFile "/run/secrets/docker/miniflux_db_password";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      miniflux = {
        image = "miniflux/miniflux:${service-version}";
        environment = {
          DATABASE_URL = "postgres://${miniflux_db_user}:${miniflux_db_password}@miniflux_db/miniflux?sslmode=disable";
          RUN_MIGRATIONS = "1";
          CREATE_ADMIN = "1";
          ADMIN_USERNAME = "${miniflux_admin_user}";
          ADMIN_PASSWORD = "${miniflux_admin_password}";
          BASE_URL = "https://miniflux.hemvist.duckdns.org";
          LISTEN_ADDR = "0.0.0.0:8081";
          POLLING_FREQUENCY = "15";
          BATCH_SIZE = "50";
        };
        ports = [
          "${service-port}:${service-port}"
        ];
        extraOptions = [
          "--network=web"
          # TODO why is the network named that?
          # "--network=clemens_backend"
          "--label=traefik.enable=true"
          "--label=traefik.http.routers.${service-name}-router.entrypoints=https"
          "--label=traefik.http.routers.${service-name}-router.rule=Host(`${service-name}.hemvist.duckdns.org`)"
          "--label=traefik.http.routers.${service-name}-router.tls=true"
          "--label=traefik.http.routers.${service-name}-router.tls.certresolver=letsEncrypt"
          # HTTP Services
          "--label=traefik.http.routers.${service-name}-router.service=${service-name}-service"
          "--label=traefik.http.services.${service-name}-service.loadbalancer.server.port=${service-port}"
        ];
        # dependsOn = [ "miniflux_db" ];
      };

      miniflux_db = {
        image = "postgres:13";
        environment = {
          POSTGRES_USER = "${miniflux_db_user}";
          POSTGRES_PASSWORD = "${miniflux_db_password}";
        };
        volumes = [
          "${docker-data}/${service-name}:/var/lib/postgresql/data"
        ];
        extraOptions = [
          # TODO why is the network named that?
          # "--network=clemens_backend"
          "--network=web"
          # TODO healthcheck buggy?
          # "--health-cmd='pg_isready -U miniflux'"
          "--health-interval=10s"
        ];
        dependsOn = [ "miniflux_db" ];
      };
    };
  };
}
