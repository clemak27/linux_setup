{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."clemens" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.username = "clemens";
            home.homeDirectory = "/home/clemens";
            home.stateVersion = "25.05";

            home.packages = with pkgs; [
              # zsh
              zsh
              starship
              zsh-completions
              zsh-syntax-highlighting

              # gay shit
              fastfetch
              hyfetch

              # cli
              bat
              curl
              delta
              eza
              fd
              fzf
              git
              github-cli
              htop
              hurl
              jq
              lazygit
              pgcli
              ripgrep
              sd
              tealdeer
              tree
              # unrar
              unzip
              viddy
              yazi
              yq
              yt-dlp

              # k8s
              krew
              kubecolor
              kubectl
              kubectx
              helm
              kustomize
              stern

              # android
              android-tools
              scrcpy

              # neovim
              gcc
              neovim

              # nix
              direnv
              nixd
              nixfmt-rfc-style

              # python
              # python313
              # python313Packages.black

              # node
              nodePackages.nodejs
              biome

              # go
              go
              gofumpt
              golangci-lint
              gomodifytags
              gotools
              delve

              # container
              hadolint

              # java
              jdk
              gradle
              # kotlin

              # md
              markdownlint-cli
              nodePackages.prettier

              # sh
              shellcheck
              shfmt

              # yaml
              yamlfmt
              yamllint

              # lua
              stylua
            ];

            programs.home-manager.enable = true;
            news.display = "silent";
          }
        ];
      };
    };
}
