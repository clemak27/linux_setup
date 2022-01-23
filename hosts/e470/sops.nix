{ config, lib, pkgs, ... }:
{
  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  # sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
  sops.defaultSopsFile = ./secrets.yaml;
  # # This will automatically import SSH keys as age keys
  # # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/home/clemens/.config/sops/age/keys.txt";
  # # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = false;
  # # This is the actual specification of the secrets.
  sops.secrets."wg/private_key" = { };
  sops.secrets."wg/op6/public_key" = { };
  sops.secrets."wg/op6/pre_shared_key" = { };
  sops.secrets."wg/zenix/public_key" = { };
  sops.secrets."wg/zenix/pre_shared_key" = { };
  sops.secrets."wg/xps15/public_key" = { };
  sops.secrets."wg/xps15/pre_shared_key" = { };

  sops.secrets.duckdns_url = { owner = "clemens"; };

  sops.secrets."docker/duckdns_token" = { };
  sops.secrets."docker/pihole_pw" = { };
  sops.secrets."docker/miniflux_admin_user" = { };
  sops.secrets."docker/miniflux_admin_password" = { };
  sops.secrets."docker/miniflux_db_user" = { };
  sops.secrets."docker/miniflux_db_password" = { };
  sops.secrets."docker/navidrome_spotify_id" = { };
  sops.secrets."docker/navidrome_spotify_secret" = { };
  sops.secrets."docker/navidrome_lastfm_apikey" = { };
  sops.secrets."docker/navidrome_lastfm_secret" = { };
  sops.secrets."docker/deemix_arl" = { };
  sops.secrets."docker/plex_claim" = { };
}
