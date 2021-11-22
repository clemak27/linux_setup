{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
  lspJar = "$HOME/.local/bin/nvim/lsp/jdtls/plugins/org.eclipse.equinox.launcher_*.jar";
  os = if pkgs.stdenv.isLinux then "linux" else "mac";
  lspConfig = "$HOME/.local/bin/nvim/lsp/jdtls/config_${os}";
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
  config = lib.mkIf (cfg.advanced && config.homecfg.dev.java && config.homecfg.dev.node.enable) {
    home.packages = [
      jdtls
    ];

    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-jdtls
    ];

    homecfg.nvim.pluginSettings = ''
      augroup lsp
        au!
        au FileType java lua require('jdtls-config').load()
      augroup end
    '';

    nvimUpdate.setupCommands = ''
      lsp_dir="${config.nvimUpdate.lspDir}"
      dap_dir="${config.nvimUpdate.dapDir}"
      current_dir=$(pwd)

      cd "$lsp_dir" || exit
      latest=$(curl --no-progress-meter "https://download.eclipse.org/jdtls/milestones/1.4.0/latest.txt")
      current=$(cat current_jdtls.txt)
      if [ "$latest" = "$current" ]
      then
        echo "[jdtls] Already up to date."
      else
        curl -O --url "https://download.eclipse.org/jdtls/milestones/1.4.0/$latest"
        mkdir -p jdtls
        tar -xzvf "$latest" -C ./jdtls
        echo "$latest" > current_jdtls.txt
        rm "$latest"
      fi

      cd "$dap_dir" || exit
      if [ -d "java-debug" ]
      then
        cd java-debug || exit
        git restore .
        if repo_updated; then ./mvnw clean install; else echo "[java-debug] Already up to date."; fi
      else
        git clone https://github.com/microsoft/java-debug.git
        cd java-debug || exit
        ./mvnw clean install
      fi
      cd "$dap_dir" || exit
      if [ -d "vscode-java-test" ]
      then
        cd vscode-java-test || exit
        git restore .
        if repo_updated; then npm run build-plugin; else echo "[vscode-java-test] Already up to date."; fi
      else
        git clone https://github.com/microsoft/vscode-java-test.git
        cd vscode-java-test || exit
        npm install
        npm run build-plugin
      fi

      cd "$current_dir" || exit
    '';

    xdg.configFile = {
      "nvim/lua/jdtls-config.lua".source = ../lua/jdtls-config.lua;
    };
  };
}
