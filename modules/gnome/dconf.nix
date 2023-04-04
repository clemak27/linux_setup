# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/clemens/Projects/linux_setup/wallpaper.png";
      picture-uri-dark = "file:///home/clemens/Projects/linux_setup/wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      current = mkUint32 0;
      per-window = false;
      sources = [ (mkTuple [ "xkb" "at" ]) ];
      xkb-options = [ "caps:escape_shifted_capslock" ];
    };

    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-theme = "Catppuccin-Mocha-Dark-Cursors";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "medium";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus-Dark";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/clemens/Projects/linux_setup/wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "freedesktop";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close:appmenu";
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-last-coordinates = mkTuple [ 48.135501 16.3855 ];
      night-light-temperature = mkUint32 3210;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      home = [ "<Super>e" ];
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "wezterm";
      name = "wezterm";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "suspend";
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ ];
      enabled-extensions = [ "background-logo@fedorahosted.org" "appindicatorsupport@rgcjonas.gmail.com" "gsconnect@andyholmes.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" "unite@hardpixel.eu" "blur-my-shell@aunetx" ];
      favorite-apps = [ "org.gnome.Nautilus.desktop" "org.mozilla.firefox.desktop" "org.wezfurlong.wezterm.desktop" ];
      welcome-dialog-last-shown-version = "43.3";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      appfolder-dialog-opacity = 0.12;
      blur-applications = true;
      blur-panel = false;
      brightness = 0.6;
      dash-opacity = 0.12;
      debug = false;
      hidetopbar = false;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
    };

    "org/gnome/shell/extensions/unite" = {
      desktop-name-text = "";
      extend-left-box = false;
      hide-activities-button = "never";
      notifications-position = "center";
      show-window-buttons = "never";
      show-window-title = "never";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Vienna', 'LOWW', true, [(0.83979426423570236, 0.2891428852314914)], [(0.84124869946126679, 0.28565222672750273)])>)>]";
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
      show-hidden = true;
    };

    "system/locale" = {
      region = "de_DE.UTF-8";
    };

    "system/proxy" = {
      mode = "none";
    };

  };
}
