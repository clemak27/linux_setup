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
      sweet
      krita
      gparted
      libreoffice
    ];

    # don't know if that works, otherwise use
    # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-to-workspace-1 = "['<Super>1']";
        switch-to-workspace-2 = "['<Super>2']";
        switch-to-workspace-3 = "['<Super>3']";
        switch-to-workspace-4 = "['<Super>4']";
        switch-to-workspace-5 = "['<Super>5']";
        switch-to-workspace-6 = "['<Super>6']";
        switch-to-workspace-7 = "['<Super>7']";
        switch-to-workspace-8 = "['<Super>8']";
      };
      "org/gnome/desktop/interface" = {
        gtk-theme = "Sweet-Dark";
        icon-theme = "candy-icons";
        cursor-theme = "Adwaita";
      };
      "org/gnome/desktop/wm/preferences" = {
        theme = "Sweet-Dark";
      };
    };

    home.file.".local/share/icons/candy-icons".source = candyIcons;
  };
}
