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
    packages = [
      "org.gtk.Gtk3theme.adw-gtk3"
      "org.gtk.Gtk3theme.adw-gtk3-dark"
      "com.calibre_ebook.calibre"
      "com.obsproject.Studio"
      "dev.vencord.Vesktop"
      "hu.irl.cameractrls"
      "org.libreoffice.LibreOffice"
      "org.signal.Signal"
      "com.valvesoftware.Steam"
      "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"
      "net.retrodeck.retrodeck"
      "org.freedesktop.Platform.VulkanLayer.MangoHud//24.08"
      "org.freedesktop.Platform.VulkanLayer.gamescope//24.08"
      "org.freedesktop.Platform.ffmpeg-full//24.08"
    ];
    overrides = {
      global = {
        Context.filesystems = [
          "xdg-config/gtk-3.0"
          "xdg-config/gtk-4.0"
        ];
      };
      "com.valvesoftware.Steam".Context = {
        talk-name = [ "org.freedesktop.Flatpak" ];
      };
    };
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
  };
}
