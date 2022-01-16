{ config, lib, pkgs, ... }:
let
  path = "$HOME/.local/share/nvim/lsp_servers/jdtls";
  lspJar = "${path}/plugins/org.eclipse.equinox.launcher_*.jar";
  os = if pkgs.stdenv.isLinux then "linux" else "mac";
  lspConfig = "${path}/config_${os}";
  jdtls = pkgs.writeShellScriptBin "jdtls" ''
    # https://github.com/mfussenegger/nvim-jdtls#language-server-installation

    GRADLE_HOME=$HOME/gradle $HOME/.nix-profile/bin/java \
      -Declipse.application=org.eclipse.jdt.ls.core.id1 \
      -Dosgi.bundles.defaultStartLevel=4 \
      -Declipse.product=org.eclipse.jdt.ls.core.product \
      -Dlog.protocol=true \
      -Dlog.level=ALL \
      -Xms1g \
      -Xmx2G \
      -jar ${lspJar} \
      -configuration "${lspConfig}" \
      -data "''${1:-$HOME/workspace}" \
      --add-modules=ALL-SYSTEM \
      --add-opens java.base/java.util=ALL-UNNAMED \
      --add-opens java.base/java.lang=ALL-UNNAMED
  '';
in
{
  config = {
    home.packages = [
      jdtls
    ];
  };
}
