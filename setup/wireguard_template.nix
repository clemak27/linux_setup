{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wireguard
  ];

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "" ];
      dns = [ "" ];
      privateKey = "";

      peers = [
        {
          publicKey = "";
          presharedKey = "";
          allowedIPs = [ "" ];
          endpoint = "";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
