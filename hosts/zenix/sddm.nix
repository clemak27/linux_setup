{ config, lib, pkgs, ... }:
let
  # https://discourse.nixos.org/t/sddm-background-image/5495
  buildTheme = { name, version, src, themeIni ? [ ] }:
    pkgs.stdenv.mkDerivation rec {
      pname = "sddm-theme-${name}";
      inherit version src;

      buildCommand = ''
        dir=$out/share/sddm/themes/${name}
        doc=$out/share/doc/${pname}

        mkdir -p $dir $doc
        if [ -d $src/${name} ]; then
          srcDir=$src/${name}
        else
          srcDir=$src
        fi
        cp -r $srcDir/* $dir/
        for f in $dir/{AUTHORS,COPYING,LICENSE,README,*.md,*.txt}; do
          test -f $f && mv $f $doc/
        done
        chmod 777 $dir/theme.conf

        ${lib.concatMapStringsSep "\n" (e: ''
          ${pkgs.crudini}/bin/crudini --set --inplace $dir/theme.conf \
            "${e.section}" "${e.key}" "${e.value}"
        '') themeIni}
      '';
    };

  customTheme = builtins.isAttrs theme;

  theme = themes.chili;
  # theme = "breeze";

  themeName =
    if customTheme
    then theme.pkg.name
    else theme;

  packages =
    if customTheme
    then [ (buildTheme theme.pkg) ] ++ theme.deps
    else [ ];

  themes = {
    chili = {
      pkg = rec {
        name = "chili";
        version = "0.1.5";
        src = pkgs.fetchFromGitHub {
          owner = "MarianArlt";
          repo = "kde-plasma-chili";
          rev = "a371123959676f608f01421398f7400a2f01ae06";
          sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
        };
        themeIni = [
          { section = "General"; key = "background"; value = ../../old/wallpaper.png; }
        ];
      };
      deps = with pkgs; [ ];
    };
  };
in
{
  environment.systemPackages = packages;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = themeName;
}
