{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg;
in
{
  options.homecfg.colors = {
    accent = lib.mkOption { type = lib.types.str; };
    fg = lib.mkOption { type = lib.types.str; };
    fg-light = lib.mkOption { type = lib.types.str; };
    bg = lib.mkOption { type = lib.types.str; };
    bg-light = lib.mkOption { type = lib.types.str; };
    bg-darker = lib.mkOption { type = lib.types.str; };
    bg-dark = lib.mkOption { type = lib.types.str; };
    ansi.color0 = lib.mkOption { type = lib.types.str; };
    ansi.color1 = lib.mkOption { type = lib.types.str; };
    ansi.color2 = lib.mkOption { type = lib.types.str; };
    ansi.color3 = lib.mkOption { type = lib.types.str; };
    ansi.color4 = lib.mkOption { type = lib.types.str; };
    ansi.color5 = lib.mkOption { type = lib.types.str; };
    ansi.color6 = lib.mkOption { type = lib.types.str; };
    ansi.color7 = lib.mkOption { type = lib.types.str; };
    ansi.color8 = lib.mkOption { type = lib.types.str; };
    ansi.color9 = lib.mkOption { type = lib.types.str; };
    ansi.color10 = lib.mkOption { type = lib.types.str; };
    ansi.color11 = lib.mkOption { type = lib.types.str; };
    ansi.color12 = lib.mkOption { type = lib.types.str; };
    ansi.color13 = lib.mkOption { type = lib.types.str; };
    ansi.color14 = lib.mkOption { type = lib.types.str; };
    ansi.color15 = lib.mkOption { type = lib.types.str; };
    orange = lib.mkOption { type = lib.types.str; };
  };

  config.homecfg.colors = {
    # accent
    accent = "#c50ed2";
    # fg
    fg = "#abb2bf";
    fg-light = "#eeeeee";
    # bg
    bg = "#161925";
    bg-light = "#181b28";
    bg-darker = "#0c0e14";
    bg-dark = "#000000";
    # black
    ansi.color0 = "#000000";
    ansi.color8 = "#2d333b";
    # red
    ansi.color1 = "#e06c75";
    ansi.color9 = "#e06c75";
    # green
    ansi.color2 = "#98c379";
    ansi.color10 = "#98c379";
    # yellow
    ansi.color3 = "#e5c07b";
    ansi.color11 = "#e5c07b";
    # blue
    ansi.color4 = "#61afef";
    ansi.color12 = "#61afef";
    # magenta
    ansi.color5 = "#c678dd";
    ansi.color13 = "#c678dd";
    # cyan
    ansi.color6 = "#56b6c2";
    ansi.color14 = "#56b6c2";
    # white
    ansi.color7 = "#555555";
    ansi.color15 = "#555555";
    # orange
    orange = "#d19a66";
  };

}
