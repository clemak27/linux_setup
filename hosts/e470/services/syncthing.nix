{ config, lib, pkgs, ... }:
let
  docker-data = "/home/clemens/data/docker";

  service-name = "syncthing";
  service-version = "1.18.4";
in
{
  config = {
    virtualisation.oci-containers.containers = {
      syncthing = {
        image = "syncthing/syncthing:${service-version}";
        ports = [
          "8384:8384"
          "22000:22000"
          "21027:21027/udp"
        ];
        volumes = [
          "/etc/timezone:/etc/timezone:ro"
          "/etc/localtime:/etc/localtime:ro"
          "${docker-data}/${service-name}/var:/var/syncthing"
          "${docker-data}/${service-name}/data:/data"
        ];
        extraOptions = [
          "--network=web"
          "--security-opt=no-new-privileges:true"
        ];
      };
    };
  };
}
