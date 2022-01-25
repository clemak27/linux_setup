{
  "org/gnome/GWeather" = {
    temperature-unit = "centigrade";
  };

  "org/gnome/desktop/calendar" = {
    show-weekdate = true;
  };

  "org/gnome/desktop/input-sources" = {
    xkb-options = [ "terminate:ctrl_alt_bksp" "caps:escape_shifted_capslock" ];
  };

  "org/gnome/desktop/interface" = {
    clock-show-seconds = true;
    clock-show-weekday = true;
    cursor-size = 24;
    cursor-theme = "Adwaita";
    enable-animations = true;
    enable-hot-corners = false;
    font-antialiasing = "grayscale";
    font-hinting = "slight";
    font-name = "Cantarell 10";
    gtk-im-module = "gtk-im-context-simple";
    gtk-theme = "Adwaita-dark";
    icon-theme = "Papirus-Dark";
    monospace-font-name = "FiraCode Nerd Font Mono 10";
    show-battery-percentage = false;
    toolbar-style = "text";
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
  };

  "org/gnome/desktop/wm/preferences" = {
    button-layout = "close:";
    theme = "Adwaita";
    titlebar-font = "Cantarell 11";
  };

  "org/gnome/evolution/calendar" = {
    use-24hour-format = true;
    week-start-day-name = "monday";
    work-day-friday = true;
    work-day-monday = true;
    work-day-saturday = false;
    work-day-sunday = false;
    work-day-thursday = true;
    work-day-tuesday = true;
    work-day-wednesday = true;
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
    show-image-thumbnails = "local-only";
  };

  "org/gnome/settings-daemon/plugins/color" = {
    night-light-enabled = true;
    night-light-temperature = "uint32 4200";
  };

  "org/gnome/settings-daemon/plugins/media-keys" = {
    area-screenshot = [ "<Shift>Print" ];
    custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" ];
    home = [ "<Super>e" ];
    screenshot = [ "Print" ];
    www = [ "<Super>b" ];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Super>k";
    command = "keepassxc";
    name = "keepassxc";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    binding = "<Super>Return";
    command = "alacritty";
    name = "alacritty";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
    binding = "<Super>i";
    command = "alacritty -e btm";
    name = "bottom";
  };

  "org/gnome/shell" = {
    disable-user-extensions = false;
    disabled-extensions = [ "native-window-placement@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" ];
    enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "gsconnect@andyholmes.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" "unite@hardpixel.eu" "blur-my-shell@aunetx" ];
  };

  "org/gnome/shell/extensions/blur-my-shell" = {
    appfolder-dialog-opacity = 0.12;
    blur-panel = false;
    brightness = 0.6;
    dash-opacity = 0.12;
    debug = false;
    hidetopbar = false;
    sigma = 30;
    static-blur = true;
  };

  "org/gnome/shell/extensions/unite" = {
    desktop-name-text = "GNOME";
    extend-left-box = false;
    greyscale-tray-icons = false;
    hide-activities-button = "never";
    notifications-position = "center";
    reduce-panel-spacing = true;
    show-window-buttons = "never";
    show-window-title = "never";
    window-buttons-placement = "first";
    window-buttons-theme = "auto";
  };

  "org/gnome/shell/extensions/user-theme" = {
    name = "";
  };

  "org/gnome/shell/keybindings" = {
    switch-to-application-1 = [ ];
    switch-to-application-2 = [ ];
    switch-to-application-3 = [ ];
    switch-to-application-4 = [ ];
  };

  "org/gnome/tweaks" = {
    show-extensions-notice = false;
  };

  "org/gtk/settings/file-chooser" = {
    date-format = "regular";
    location-mode = "path-bar";
    show-hidden = false;
    show-size-column = true;
    show-type-column = true;
    sort-column = "name";
    sort-directories-first = true;
    sort-order = "ascending";
    type-format = "category";
  };

}
