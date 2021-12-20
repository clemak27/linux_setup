{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wireguard
  ];

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.6.0.1/24" ];
      listenPort = 51820;
      privateKeyFile = "/run/secrets/wg/private_key";
      mtu = 1420;
      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o enp4s0 -j MASQUERADE -s 10.6.0.1/24
      '';
      preDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -o enp4s0 -j MASQUERADE -s 10.6.0.1/24
      '';
      peers = [
        {
          # op6
          publicKey = builtins.readFile "/run/secrets/wg/op6/public_key";
          presharedKeyFile = "/run/secrets/wg/op6/pre_shared_key";
          allowedIPs = [ "10.6.0.2/32" ];
        }
        {
          # zenix
          publicKey = builtins.readFile "/run/secrets/wg/zenix/public_key";
          presharedKeyFile = "/run/secrets/wg/zenix/pre_shared_key";
          allowedIPs = [ "10.6.0.3/32" ];
        }
        {
          # xps15
          publicKey = builtins.readFile "/run/secrets/wg/xps15/public_key";
          presharedKeyFile = "/run/secrets/wg/xps15/pre_shared_key";
          allowedIPs = [ "10.6.0.4/32" ];
        }
      ];
    };
  };
}
