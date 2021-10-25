{ config, pkgs, ... }:
{
  # spicy as fuck
  users.users.clemens = {
    password = "";
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "" ];
      dns = [ "" ];
      privateKey = "";

      peers = [
        {
          publicKey = "";
          presharedKey = "";
          allowedIPs = [ "" "" ];
          endpoint = "";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
