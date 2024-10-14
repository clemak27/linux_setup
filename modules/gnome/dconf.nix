# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      # current = mkUint32 0;
      per-window = false;
      # sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "at" ]) ];
      xkb-options = [ "caps:escape_shifted_capslock" ];
    };

    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-theme = "catppuccin-mocha-dark-cursors";
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
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
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
      switch-to-workspace-right = [ "<Super>Page_Down" "<Super><Alt>Right" "<Control><Alt>Right" "<Super><Alt>L" ];
      switch-to-workspace-left = [ "<Super>Page_Up" "<Super><Alt>Left" "<Control><Alt>Left" "<Super><Alt>H" ];
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
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-last-coordinates = mkTuple [ 48.135501 16.3855 ];
      night-light-temperature = mkUint32 3700;
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
      enabled-extensions = [ "blur-my-shell@aunetx" "appindicatorsupport@rgcjonas.gmail.com" "gsconnect@andyholmes.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" "unite@hardpixel.eu" "pip-on-top@rafostar.github.com" "panelScroll@sun.wxg@gmail.com" "openbar@neuromorph" ];
      favorite-apps = [ "org.gnome.Nautilus.desktop" "firefox.desktop" "org.wezfurlong.wezterm.desktop" "feishin.desktop" ];
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
      brightness = 1.0;
      customize = true;
      override-background = true;
      override-background-dynamically = true;
      sigma = 5;
      static-blur = false;
      style-panel = 0;
      unblur-in-overview = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      dynamic-opacity = false;
      opacity = 255;
      sigma = 15;
      whitelist = [ "org.wezfurlong.wezterm" ];
    };

    "org/gnome/shell/extensions/unite" = {
      autofocus-windows = false;
      enable-titlebar-actions = false;
      extend-left-box = false;
      hide-activities-button = "never";
      hide-app-menu-icon = false;
      hide-window-titlebars = "maximized";
      notifications-position = "center";
      reduce-panel-spacing = true;
      restrict-to-primary-screen = true;
      show-appmenu-button = false;
      show-desktop-name = false;
      show-legacy-tray = false;
      show-window-buttons = "never";
      show-window-title = "maximized";
      use-activities-text = false;
      window-buttons-theme = "catppuccin";
    };

    "org/gnome/shell/extensions/openbar" = {
      apply-flatpak = false;
      apply-gtk = false;
      auto-bgalpha = true;
      autofg-bar = true;
      autofg-menu = true;
      autohg-bar = true;
      autohg-menu = true;
      autotheme-dark = "Color";
      autotheme-font = true;
      autotheme-light = "Color";
      autotheme-refresh = true;
      color-scheme = "prefer-dark";
      notif-radius = 10.0;
      position = "Top";
      qtoggle-radius = 10.0;
      set-fullscreen = true;
      set-notifications = false;
      set-overview = true;
      set-yarutheme = false;
      shadow = false;
      wmaxbar = true;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "";
    };

    "org/gnome/shell/extensions/panelScroll" = {
      debounce = 0;
      left = "workspace";
      right = "workspace";
      wrap = false;
    };

    "org/gnome/shell/extensions/pip-on-top" = {
      stick = true;
    };

    "org/gnome/shell/keybindings" = {
      toggle-overview = [ "<Super>s" ];
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Vienna', 'LOWW', true, [(0.83979426423570236, 0.2891428852314914)], [(0.84124869946126679, 0.28565222672750273)])>)>]";
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
    };

    "system/locale" = {
      region = "de_DE.UTF-8";
    };

    "system/proxy" = {
      mode = "none";
    };

  };
}
