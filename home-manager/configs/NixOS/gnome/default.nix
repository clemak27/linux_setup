{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  candyIcons = pkgs.stdenv.mkDerivation {
    name = "candy-icons";
    src = ./candy-icons.tar.gz;
    # src = pkgs.fetchFromGitHub {
    #   owner = "EliverLara";
    #   repo = "candy-icons";
    #   rev = "033c24b4fe4ae3eeb097f2f624c27ebc1c58e3f6";
    #   sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
    # };
    installPhase = ''
      mkdir -p $out
      cp -R . $out
    '';
  };
in
{
  options.homecfg.NixOS = {
    gnome = lib.mkEnableOption "Setup GNOME customization with home-manager";
  };

  config = lib.mkIf (cfg.enable && cfg.gnome) {
    home.packages = with pkgs; [

      gnomeExtensions.appindicator
      gnomeExtensions.unite
      gnomeExtensions.gsconnect
      gnomeExtensions.blur-my-shell

      sweet

      gimp
      gparted
      libreoffice
    ];

    dconf.settings = import ./dconf.nix;

    home.file.".local/share/icons/candy-icons".source = candyIcons;
  };
}
