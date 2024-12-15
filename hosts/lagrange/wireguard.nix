{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.wg-quick.interfaces = {
    home = {
      address = [ "10.6.0.7/24" ];
      dns = [ "10.6.0.1" ];
      privateKeyFile = "/etc/wireguard/private_key";

      peers = [
        {
          publicKey = builtins.readFile "/etc/wireguard/public_key";
          presharedKeyFile = "/etc/wireguard/pre_shared_key";
          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
          endpoint = "wallstreet30.cc:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
