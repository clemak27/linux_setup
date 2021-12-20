{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wireguard
  ];

  networking.wg-quick.interfaces = {
    home = {
      address = [ "10.6.0.4/24" ];
      dns = [ "10.6.0.1" ];
      privateKeyFile = "/run/secrets/wg/private_key";

      peers = [
        {
          publicKey = builtins.readFile "/run/secrets/wg/public_key";
          presharedKeyFile = "/run/secrets/wg/pre_shared_key";
          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
          endpoint = "hemvist.duckdns.org:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
