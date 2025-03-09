{ ... }:
{
  home = {
    username = "clemens";
    homeDirectory = "/home/clemens";
    stateVersion = "24.05";
  };

  homecfg = {
    dev.enable = true;
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      ssh_key = builtins.readFile /home/clemens/.ssh/id_ed25519.pub;
      gh = true;
    };
    k8s.enable = true;
    nvim.enable = true;
    tools.enable = true;
    wezterm.enable = true;
    zsh.enable = true;
  };

  services.syncthing.enable = true;
  services.flatpak = {
    "com.valvesoftware.Steam".Context = {
      talk-name = [ "org.freedesktop.Flatpak" ];
    };
  };
  update.auto = {
    enable = true;
    onCalendar = "daily";
  };
}
