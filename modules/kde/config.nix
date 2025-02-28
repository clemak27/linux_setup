{ pkgs, osConfig, ... }:
let
  kssh = pkgs.writeShellApplication {
    name = "kssh";
    runtimeInputs = with pkgs; [
      kdePackages.ksshaskpass
    ];
    text = ''
      SSH_ASKPASS=ksshaskpass ssh-add < /dev/null
    '';
  };
  accents = {
    "maxwell" = "#365282";
    "newton" = "#029677";
  };
  lookupAccent = attrs: key: if attrs ? "${key}" then attrs."${key}" else "#760088";
  theme = ''
    @define-color window_bg_color #000000;
    @define-color window_fg_color #f8f8f2;
    @define-color view_bg_color #121212;
    @define-color view_fg_color @window_fg_color;
    @define-color accent_bg_color ${lookupAccent accents osConfig.networking.hostName};
    @define-color accent_color @accent_bg_color;
    @define-color headerbar_bg_color @window_bg_color;
    @define-color headerbar_fg_color @window_fg_color;
    @define-color popover_bg_color #121212;
    @define-color popover_fg_color @view_fg_color;
    @define-color dialog_bg_color @popover_bg_color;
    @define-color dialog_fg_color @popover_fg_color;
    @define-color card_bg_color rgba(255, 255, 255, 0.05);
    @define-color card_fg_color @window_fg_color;

    @import 'colors.css';
  '';
in
{
  config = {
    # use ksshaskpass to manage ssh keys
    xdg.configFile."autostart/ksshaskpass.desktop".text = ''
      [Desktop Entry]
      Exec=${kssh}/bin/kssh
      Icon=application-x-shellscript
      Name=ksshaskpass
      Type=Application
    '';

    home.file.".local/share/konsole/MochaMatte.colorscheme".source = ./MochaMatte.colorscheme;

    programs.zsh = {
      shellAliases = builtins.listToAttrs ([
        {
          name = "youtube-dl";
          value = "yt-dlp";
        }
        {
          name = "youtube-dl-music";
          value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\"";
        }
      ]);
      initExtra = builtins.concatStringsSep "\n" [
        # set correct locale
        "export LC_ALL=en_GB.UTF-8"
      ];
    };

    home.packages = with pkgs; [
      feishin
      mpv
      yt-dlp

      scrcpy
    ];

    xdg.configFile."gtk-3.0/gtk.css".text = theme;
    xdg.configFile."gtk-4.0/gtk.css".text = theme;

    programs.plasma = {
      enable = true;
      window-rules = [
        {
          description = "Firefox PiP";
          match = {
            window-class = {
              value = "firefox";
              type = "substring";
            };
            title = "Picture-in-Picture";
            window-types = [ "normal" ];
          };
          apply = {
            above = true;
            aboverule = 2;
            desktops = "\\0";
            desktopsrule = 2;
            skippager = true;
            skippagerrule = 2;
            skipswitcher = true;
            skipswitcherrule = 2;
            skiptaskbar = true;
            skiptaskbarrule = 2;
          };
        }
      ];
      configFile = {
        "dolphinrc"."DetailsMode"."ExpandableFolders" = false;
        "dolphinrc"."DetailsMode"."PreviewSize" = 32;
        "dolphinrc"."General"."ConfirmClosingMultipleTabs" = false;
        "dolphinrc"."General"."RememberOpenedTabs" = false;
        "dolphinrc"."General"."ShowZoomSlider" = false;
        "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
        "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
        "kcminputrc"."Mouse"."cursorTheme" = "breeze_cursors";
        "kdeglobals"."General"."accentColorFromWallpaper" = true;
        "kdeglobals"."Icons"."Theme" = "Papirus-Dark";
        "kdeglobals"."KDE"."ShowDeleteCommand" = false;
        "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
        "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
        "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
        "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
        "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
        "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
        "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
        "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
        "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
        "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
        "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
        "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
        "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
        "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
        "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 140;
        "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
        "kdeglobals"."PreviewSettings"."EnableRemoteFolderThumbnail" = false;
        "kdeglobals"."PreviewSettings"."MaximumRemoteSize" = 0;
        "kiorc"."Confirmations"."ConfirmDelete" = true;
        "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
        "kiorc"."Confirmations"."ConfirmTrash" = false;
        "kiorc"."Executable scripts"."behaviourOnLaunch" = "alwaysAsk";
        "klaunchrc"."BusyCursorSettings"."Bouncing" = false;
        "krunnerrc"."General"."FreeFloating" = true;
        "krunnerrc"."Plugins"."krunner_katesessionsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_konsoleprofilesEnabled" = false;
        "krunnerrc"."Plugins/Favorites"."plugins" = "krunner_services,krunner_systemsettings";
        "kscreenlockerrc"."Daemon"."Autolock" = false;
        "kscreenlockerrc"."Daemon"."Timeout" = 0;
        "kwinrc"."Effect-overview"."BorderActivate" = 9;
        "kwinrc"."NightColor"."Active" = true;
        "kwinrc"."NightColor"."NightTemperature" = 4400;
        "kwinrc"."Plugins"."blurEnabled" = false;
        "kwinrc"."Plugins"."contrastEnabled" = false;
        "kwinrc"."Xwayland"."Scale" = 1;
        "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "X";
        "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "F";
        # "kxkbrc"."Layout"."LayoutList" = "us";
        # "kxkbrc"."Layout"."Use" = true;
        # "kxkbrc"."Layout"."VariantList" = "altgr-intl";
        "plasma-localerc"."Formats"."LANG" = "en_GB.UTF-8";
        "plasma-localerc"."Formats"."LC_ADDRESS" = "de_AT.UTF-8";
        "plasma-localerc"."Formats"."LC_MEASUREMENT" = "de_AT.UTF-8";
        "plasma-localerc"."Formats"."LC_MONETARY" = "de_AT.UTF-8";
        "plasma-localerc"."Formats"."LC_NAME" = "de_AT.UTF-8";
        "plasma-localerc"."Formats"."LC_NUMERIC" = "de_AT.UTF-8";
        "plasma-localerc"."Formats"."LC_PAPER" = "de_AT.UTF-8";
        "plasma-localerc"."Formats"."LC_TELEPHONE" = "de_AT.UTF-8";
        "plasma-localerc"."Formats"."LC_TIME" = "de_AT.UTF-8";
      };
      dataFile = {
        "dolphin/view_properties/global/.directory"."Dolphin"."SortHiddenLast" = true;
        "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
        "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
      };
    };
  };
}
