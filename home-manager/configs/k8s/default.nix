{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg;
  starshipK8s = pkgs.writeShellScriptBin "starship-toggle-k8s" ''
        #!/bin/sh

        if [ -x "$(which starship)" ] ; then
          if [ -e "$HOME/.config/starship-k8s.toml" ] ; then
            if env | grep STARSHIP_CONFIG > /dev/null
            then
              unset STARSHIP_CONFIG
            else
              export STARSHIP_CONFIG="$HOME/.config/starship-k8s.toml"
            fi
          else
            echo "k8s config not found, generating..."
            {
            sed '/kubernetes/,$ d' "$HOME/.config/starship.toml"
            echo '[kubernetes]'
            echo 'disabled = false'
            echo 'format = "[$symbol$context( ($namespace))]($style) "'
            echo ""
            echo "[line_break]"
            echo "disabled = false"
            echo ""
            sed '/memory_usage/,$ !d' "$HOME/.config/starship.toml"
        } > "$HOME/.config/starship-k8s.toml"

      fi
    else
     echo "starship not found"
    fi
  '';
in
{
  options.homecfg.k8s = {
    enable = lib.mkEnableOption "Manage kubernetes with home-manager";
  };

  config = lib.mkIf (cfg.k8s.enable) {

    home.packages = with pkgs; [
      kubectl
      kubectx
      kubernetes-helm
      stern
      starshipK8s
      kind
    ];

    programs.zsh.oh-my-zsh.plugins = [
      "kubectl"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "kgaw"; value = "watch -n 1 --no-title kubectl get all"; }
        { name = "stk"; value = "source starship-toggle-k8s"; }
      ]
    );
  };
}
