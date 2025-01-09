{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homecfg;
  getYaml = pkgs.writeShellApplication {
    name = "ky";
    runtimeInputs = with pkgs; [
      kubectl
      bat
    ];
    text = ''
      kubectl "$@" -o yaml | bat -p -P --language=yaml
    '';
  };
  watchkResource = pkgs.writeShellApplication {
    name = "wk";
    runtimeInputs = with pkgs; [
      viddy
      kubecolor
    ];
    text = ''
      viddy --no-title --disable_auto_save kubecolor --force-colors "$@"
    '';
  };
  watchAll = pkgs.writeShellApplication {
    name = "kgaw";
    runtimeInputs = [ watchkResource ];
    text = ''
      wk get all
    '';
  };
in
{
  options.homecfg.k8s = {
    enable = lib.mkEnableOption "Manage kubernetes with home-manager";
  };

  config = lib.mkIf (cfg.k8s.enable) {

    home.packages = with pkgs; [
      krew
      kubectl
      kubectx
      kubernetes-helm
      kubecolor
      kustomize
      stern

      getYaml
      watchkResource
      watchAll
    ];

    programs.zsh.oh-my-zsh.plugins = [
      "kubectl"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs ([
      {
        name = "kns";
        value = "kubens";
      }
      {
        name = "kctx";
        value = "kubectx";
      }
      {
        name = "ky";
        value = "${getYaml}/bin/ky";
      }
    ]);

    programs.zsh.initExtra = ''
      source <(kubecolor completion zsh)
      alias kubectl=kubecolor
      compdef kubecolor=kubectl

      # https://github.com/ohmyzsh/ohmyzsh/issues/12515
      unalias k &> /dev/null || :
      function k() { kubectl "$@" }
      compdef _kubectl k

      export PATH="$HOME/.krew/bin:$PATH"
    '';
  };
}
