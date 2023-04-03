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
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, homecfg, sops-nix, flake-utils }:
    let
      devpkgs = nixpkgs.legacyPackages.x86_64-linux;
      overlay-stable = final: prev: {
        stable = self.inputs.nixpkgs-stable.legacyPackages.x86_64-darwin;
      };
    in
    {
      nixosConfigurations = {
        argentum = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/argentum/configuration.nix
          ];
        };

        silfur = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/silfur/configuration.nix
          ];
        };

        virtual = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/virtual/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        clemens = home-manager.lib.homeManagerConfiguration {
          pkgs = self.inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ overlay-stable ];
              nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
            })
            homecfg.nixosModules.homecfg
            ./modules/home.nix
            {
              home = {
                username = "clemens";
                homeDirectory = "/home/clemens";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };

      devShell.x86_64-linux = devpkgs.mkShell {
        nativeBuildInputs = with devpkgs; [
          sops
          dconf2nix
        ];
      };
    };
}
