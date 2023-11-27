{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homecfg = {
      url = "github:clemak27/homecfg";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tdt = {
      url = "git+ssh://git@gitea.wallstreet30.cc:222/clemak27/tdt.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nurl = {
      url = "github:nix-community/nurl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, homecfg, pre-commit-hooks, nix-index-database, plasma-manager, nurl, tdt, zjstatus }:
    let
      legacyPkgs = nixpkgs.legacyPackages.x86_64-linux;
      overlay-stable = final: prev: {
        stable = nixpkgs-stable.legacyPackages.x86_64-linux;
      };
      overlay-customPkgs = final: prev: {
        tdtPkgs = tdt.packages.x86_64-linux;
        zjStatus = zjstatus.packages.x86_64-linux.default;
      };
      nixModule = ({ config, pkgs, ... }: {
        nixpkgs.overlays = [ overlay-stable overlay-customPkgs ];
        nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
        nixpkgs.config = {
          allowUnfree = true;
        };
      });
    in
    {
      homeConfigurations = {
        clemens = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPkgs;
          modules = [
            nixModule
            ./home.nix
            homecfg.nixosModules.homecfg
            nix-index-database.hmModules.nix-index
            plasma-manager.homeManagerModules.plasma-manager
          ];
        };

        deck = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPkgs;
          modules = [
            nixModule
            homecfg.nixosModules.homecfg
            nix-index-database.hmModules.nix-index
            ({ config, pkgs, ... }: {
              home = {
                username = "deck";
                homeDirectory = "/home/deck";
                stateVersion = "23.05";
                packages = [
                  pkgs.gnumake
                ];
              };
              news.display = "silent";
              homecfg = {
                git.enable = true;
                tools.enable = true;
                zsh.enable = true;
              };
              services.syncthing.enable = true;
              programs.zsh = {
                shellAliases = builtins.listToAttrs (
                  [
                    { name = "hms"; value = "git -C /home/deck/Projects/linux_setup pull --rebase && home-manager switch --flake /home/deck/Projects/linux_setup"; }
                  ]
                );

                initExtra = ''
                  if [ -z "$NIX_PROFILES" ]; then
                    . $HOME/.nix-profile/etc/profile.d/nix.sh
                  fi

                  # export correct shell
                  export SHELL="$HOME/.nix-profile/bin/zsh"

                  export GIT_SSH="/usr/bin/ssh";
                '';
              };
            })
          ];
        };
      };

      checks.x86_64-linux = {
        pre-commit-check = pre-commit-hooks.lib.x86_64-linux.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            actionlint.enable = true;
            checkmake.enable = true;
            shellcheck_fixed = {
              enable = true;
              name = "shellcheck";
              description = "Format shell files.";
              types = [ "shell" ];
              entry = "${legacyPkgs.shellcheck}/bin/shellcheck";
            };
          };
        };
      };

      devShells.x86_64-linux.default =
        legacyPkgs.mkShell
          {
            inherit (self.checks.x86_64-linux.pre-commit-check) shellHook;

            packages = with legacyPkgs; [
              sops
              nurl.packages.x86_64-linux.default
            ];
          };
    };
}
