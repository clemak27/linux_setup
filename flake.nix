{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homecfg = {
      url = "github:clemak27/homecfg";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, homecfg }:
    let
      overlay-stable = final: prev: {
        stable = self.inputs.nixpkgs-stable.legacyPackages.x86_64-darwin;
      };
    in
    {
      homeConfigurations = {
        "clemens@toolbox" = home-manager.lib.homeManagerConfiguration {
          pkgs = self.inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ overlay-stable ];
              nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
            })
            homecfg.nixosModules.homecfg
            homecfg.nixosModules.nvim-packer
            ./home.nix
            {
              home = {
                username = "clemens";
                homeDirectory = "/home/clemens";
                stateVersion = "21.05";
              };
            }
          ];
        };
      };
    };
}
