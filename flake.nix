{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homecfg = {
      url = "github:clemak27/homecfg";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tdt = {
      url = "git+ssh://git@gitea.wallstreet30.cc:222/clemak27/tdt.git";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };

    helix.url = "github:helix-editor/helix";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, homecfg, sops-nix, flake-utils-plus, pre-commit-hooks, nix-index-database, tdt, helix }:
    let
      pkgs = self.pkgs.x86_64-linux.nixpkgs;
    in
    flake-utils-plus.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channels.nixpkgs = {
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "nodejs-16.20.0"
            "nodejs-16.20.1"
          ];
        };
        overlaysBuilder = channels: [
          (final: prev: {
            stable = self.inputs.nixpkgs-stable.legacyPackages.x86_64-linux;
            tdtPkgs = self.inputs.tdt.packages.x86_64-linux;
            helixPkgs = self.inputs.helix.packages.x86_64-linux;
          })
        ];
      };

      hostDefaults = {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops

          ./modules/autoupdate.nix
          ./modules/general.nix
          ./modules/gnome
          ./modules/pipewire.nix
          ./modules/virt-manager.nix
          ./modules/container.nix
          ./modules/ssh.nix
          ./modules/flatpak.nix

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.clemens = { config, pkgs, ... }: {
              imports = [
                homecfg.nixosModules.homecfg
                nix-index-database.hmModules.nix-index
                ./modules/home.nix
              ];
              home = {
                username = "clemens";
                homeDirectory = "/home/clemens";
                stateVersion = "22.11";
              };

              nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
            };
          }
        ];
        channelName = "nixpkgs";
      };

      hosts = {
        argentum = {
          modules = [
            ./hosts/argentum/configuration.nix
          ];
        };

        silfur = {
          modules = [
            ./hosts/silfur/configuration.nix
          ];
        };

        virtual = {
          modules = [
            ./hosts/virtual/configuration.nix
          ];
        };
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
              entry = "${pkgs.shellcheck}/bin/shellcheck";
            };
          };
        };
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        inherit (self.checks.x86_64-linux.pre-commit-check) shellHook;

        packages = with pkgs; [
          sops
          dconf2nix
        ];
      };
    };
}
