{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      nix-index-database,
      lanzaboote,
      nix-on-droid,
      nixgl,
      plasma-manager,
      nix-flatpak,
      disko,
      pre-commit-hooks,
    }:
    let
      legacyPkgs = nixpkgs.legacyPackages.x86_64-linux;
      overlay-stable = final: prev: {
        stable = nixpkgs-stable.legacyPackages.x86_64-linux;
      };
      overlay-customPkgs = final: prev: {
        nixgl = nixgl.defaultPackage.x86_64-linux;
      };
      nixModule = (
        { ... }:
        {
          nixpkgs.overlays = [
            overlay-stable
            overlay-customPkgs
          ];
          nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
          nixpkgs.config = {
            allowUnfree = true;
          };
        }
      );
      hmDesktopModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.clemens =
          { pkgs, ... }:
          {
            imports = [
              nix-index-database.hmModules.nix-index
              plasma-manager.homeManagerModules.plasma-manager
              nix-flatpak.homeManagerModules.nix-flatpak
              ./modules/home/common.nix
              ./modules/home/default.nix
              ./modules/kde/config.nix
            ];

            nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
          };
      };
      desktopModules = [
        nixModule
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko

        ./modules/default.nix
        ./modules/desktop.nix
        ./modules/kde/default.nix

        hmDesktopModule
      ];
    in
    {
      nixosConfigurations.maxwell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = desktopModules ++ [
          ./hosts/maxwell/configuration.nix
        ];
      };

      nixosConfigurations.newton = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = desktopModules ++ [
          ./hosts/newton/configuration.nix
        ];
      };

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        system = "aarch64-linux";
        modules = [
          ./hosts/planck/configuration.nix
        ];
      };

      homeConfigurations.deck = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPkgs;
        modules = [
          nixModule
          nix-index-database.hmModules.nix-index
          nix-flatpak.homeManagerModules.nix-flatpak
          ./hosts/fermi/configuration.nix
        ];
      };

      checks.x86_64-linux = {
        pre-commit-check = pre-commit-hooks.lib.x86_64-linux.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
            commitizen.enable = true;
          };
        };
      };

      devShell.x86_64-linux = legacyPkgs.mkShell {
        inherit (self.checks.x86_64-linux.pre-commit-check) shellHook;
        packages = with legacyPkgs; [
          sops
          efibootmgr
          sbctl
          nvd
        ];
      };
    };
}
