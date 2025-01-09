{ ... }:
{
  imports = [
    ./dev
    ./git
    ./k8s
    ./nvim
    ./tools
    ./wezterm
    ./zsh
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
