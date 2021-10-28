{ config, pkgs, ... }:
{
  # spicy as fuck
  users.users.clemens = {
    hashedPassword = "";
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
