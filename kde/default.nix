{
  programs.plasma = {
    enable = true;
    configFile = {
      "dolphinrc"."DetailsMode"."ExpandableFolders" = false;
      "dolphinrc"."DetailsMode"."PreviewSize" = 32;
      "dolphinrc"."General"."ConfirmClosingMultipleTabs" = false;
      "dolphinrc"."General"."RememberOpenedTabs" = false;
      "dolphinrc"."General"."ShowZoomSlider" = false;
      "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      "kdeglobals"."KDE"."ShowDeleteCommand" = false;
      "kdeglobals"."KDE"."SingleClick" = false;
      "kdeglobals"."KDE"."widgetStyle" = "Breeze";
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
      "kdeglobals"."KFileDialog Settings"."Show hidden files" = true;
      "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = true;
      "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      "kiorc"."Confirmations"."ConfirmDelete" = true;
      "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
      "kiorc"."Confirmations"."ConfirmTrash" = false;
      "klaunchrc"."BusyCursorSettings"."Bouncing" = false;
      "klipperrc"."General"."KeepClipboardContents" = false;
      "klipperrc"."General"."SelectionTextOnly" = false;
      "krunnerrc"."General"."FreeFloating" = true;
      "ksmserverrc"."General"."loginMode" = "emptySession";
      "kwinrc"."Desktops"."Number" = 5;
      "kwinrc"."Desktops"."Rows" = 1;
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."NightColor"."NightTemperature" = 4400;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "X";
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "S";
      "kxkbrc"."Layout"."Options" = "caps:escape_shifted_compose";
      "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
      "plasma-localerc"."Formats"."LC_ADDRESS" = "de_AT.UTF-8";
      "plasma-localerc"."Formats"."LC_MEASUREMENT" = "de_AT.UTF-8";
      "plasma-localerc"."Formats"."LC_MONETARY" = "de_AT.UTF-8";
      "plasma-localerc"."Formats"."LC_NAME" = "de_AT.UTF-8";
      "plasma-localerc"."Formats"."LC_NUMERIC" = "de_AT.UTF-8";
      "plasma-localerc"."Formats"."LC_PAPER" = "de_AT.UTF-8";
      "plasma-localerc"."Formats"."LC_TELEPHONE" = "de_AT.UTF-8";
      "plasma-localerc"."Formats"."LC_TIME" = "de_AT.UTF-8";
      "systemsettingsrc"."KFileDialog Settings"."detailViewIconSize" = 16;
    };
  };

  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
