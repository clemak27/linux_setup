{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homecfg = {
      url = "github:clemak27/homecfg";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, homecfg, nix-index-database, lanzaboote }:
    let
      legacyPkgs = nixpkgs.legacyPackages.x86_64-linux;
      overlay-stable = final: prev: {
        stable = nixpkgs-stable.legacyPackages.x86_64-linux;
      };
      # overlay-customPkgs = final: prev: {
      #   tdtPkgs = tdt.packages.x86_64-linux;
      #   czb = custom-zellij-bar.packages.x86_64-linux;
      # };
      nixModule = ({ config, pkgs, ... }: {
        nixpkgs.overlays = [ overlay-stable ];
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
            homecfg.hmModules.homecfg
            nix-index-database.hmModules.nix-index
            ./modules/home.nix
          ];
          home = {
            username = "clemens";
            homeDirectory = "/home/clemens";
            stateVersion = "24.05";
          };

          nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
        };
      };
      defaultModules = [
        nixModule
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager

        ./modules/gnome
        ./modules/gaming.nix
        ./modules/general.nix
        ./modules/pipewire.nix
        ./modules/ssh.nix
        ./modules/virt-manager.nix

        hmModule
      ];
    in
    {
      nixosConfigurations.maxwell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./hosts/maxwell/configuration.nix
          ./modules/secureboot.nix
        ];
      };

      # nixosConfigurations.silfur = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = defaultModules ++ [
      #     ./hosts/silfur/configuration.nix
      #   ];
      # };

      devShell.x86_64-linux =
        legacyPkgs.mkShell {
          packages = with legacyPkgs; [
            sops
            dconf2nix
          ];
        };
    };
}
