{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homecfg = {
      url = "github:clemak27/homecfg";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    # flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tdt = {
      url = "git+ssh://git@gitea.wallstreet30.cc:222/clemak27/tdt.git";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };

    custom-zellij-bar = {
      url = "git+ssh://git@gitea.wallstreet30.cc:222/clemak27/custom-zellij-bar.git";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
    };

    # helix.url = "github:helix-editor/helix";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, homecfg, sops-nix, pre-commit-hooks, nix-index-database, plasma-manager, custom-zellij-bar, tdt }:
    let
      legacyPkgs = nixpkgs.legacyPackages.x86_64-linux;
      overlay-stable = final: prev: {
        stable = nixpkgs-stable.legacyPackages.x86_64-linux;
      };
      overlay-customPkgs = final: prev: {
        tdtPkgs = tdt.packages.x86_64-linux;
        czb = custom-zellij-bar.packages.x86_64-linux;
      };
      nixModule = ({ config, pkgs, ... }: {
        nixpkgs.overlays = [ overlay-stable overlay-customPkgs ];
        nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
        nixpkgs.config = {
          allowUnfree = true;
        };
      });
      hmModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.clemens = { config, pkgs, ... }: {
          imports = [
            homecfg.nixosModules.homecfg
            nix-index-database.hmModules.nix-index
            plasma-manager.homeManagerModules.plasma-manager
            ./modules/home.nix
          ];
          home = {
            username = "clemens";
            homeDirectory = "/home/clemens";
            stateVersion = "22.11";
          };

          nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
        };
      };
      defaultModules = [
        nixModule
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager

        ./modules/autoupdate.nix
        ./modules/container.nix
        ./modules/gaming.nix
        ./modules/general.nix
        ./modules/kde
        ./modules/pipewire.nix
        ./modules/ssh.nix
        ./modules/virt-manager.nix

        hmModule
      ];
    in
    {
      nixosConfigurations.argentum = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./hosts/argentum/configuration.nix
          {
            home-manager.users.clemens = { config, pkgs, ... }: {
              home.file.".wallpaper.png".source = ./hosts/argentum/wallpaper.png;
            };
          }
        ];
      };

      nixosConfigurations.silfur = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./hosts/silfur/configuration.nix
          {
            home-manager.users.clemens = { config, pkgs, ... }: {
              home.file.".wallpaper.png".source = ./hosts/silfur/wallpaper.png;
            };
          }
        ];
      };

      checks.x86_64-linux = {
        pre-commit-check = pre-commit-hooks.lib.x86_64-linux.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            actionlint.enable = true;
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

      devShell.x86_64-linux =
        legacyPkgs.mkShell {
          inherit (self.checks.x86_64-linux.pre-commit-check) shellHook;

          packages = with legacyPkgs; [
            sops
            dconf2nix
          ];
        };
    };
}
