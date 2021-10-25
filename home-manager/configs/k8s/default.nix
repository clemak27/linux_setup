{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg;
in
{
  options.homecfg.k8s = {
    enable = lib.mkEnableOption "Manage kubernetes with home-manager";
    localDev = lib.mkEnableOption "Setup k3d to start a local cluster";
  };

  config = lib.mkIf (cfg.k8s.enable) {

    home.packages = with pkgs; [
      kubectl
      kubectx
      kubernetes-helm
      stern
    ] ++ lib.optionals cfg.k8s.localDev [
      kube3d
    ];

    programs.zsh.oh-my-zsh.plugins = [
      "kubectl"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "kgaw"; value = "watch -n 1 --no-title kubectl get all"; }
      ]
    );
  };
}
