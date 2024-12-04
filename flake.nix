{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homecfg = {
      url = "github:clemak27/homecfg";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
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
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , homecfg
    , nix-index-database
    , lanzaboote
    , nix-on-droid
    , nixgl
    , plasma-manager
    , nix-flatpak
    , zjstatus
    }:
    let
      legacyPkgs = nixpkgs.legacyPackages.x86_64-linux;
      overlay-stable = final: prev: {
        stable = nixpkgs-stable.legacyPackages.x86_64-linux;
      };
      overlay-customPkgs = final: prev: {
        nixgl = nixgl.defaultPackage.x86_64-linux;
        zjstatus = zjstatus.packages.x86_64-linux.default;
      };
      nixModule = ({ ... }: {
        nixpkgs.overlays = [ overlay-stable overlay-customPkgs ];
        nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
        nixpkgs.config = {
          allowUnfree = true;
        };
      });
      hmModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.clemens = { ... }: {
          imports = [
            homecfg.hmModules.homecfg
            nix-index-database.hmModules.nix-index
            plasma-manager.homeManagerModules.plasma-manager
            nix-flatpak.homeManagerModules.nix-flatpak
            ./modules/home/default.nix
          ];
          home = {
            username = "clemens";
            homeDirectory = "/home/clemens";
            stateVersion = "24.05";
          };

          nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
        };
      };
      desktopModules = [
        nixModule
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak

        ./modules/default.nix
        ./modules/desktop.nix
        ./modules/kde/default.nix
        ./modules/secureboot.nix

        hmModule
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
          homecfg.hmModules.homecfg
          nix-index-database.hmModules.nix-index
          ./hosts/fermi/configuration.nix
        ];
      };

      devShell.x86_64-linux =
        legacyPkgs.mkShell {
          packages = with legacyPkgs; [
            sops
            dconf2nix
            efibootmgr
            sbctl
          ];
        };
    };
}
