{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music
    gnome.gnome-terminal
    gnome.gedit
    epiphany
    gnome.totem
    gnome-tour
    gnome.geary
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks

    gnomeExtensions.appindicator
    gnomeExtensions.unite
    gnomeExtensions.gsconnect
    gnomeExtensions.blur-my-shell


    xclip
  ];

  programs.evolution.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "de";

  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
  # gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"

}
