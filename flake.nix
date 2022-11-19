{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homecfg = {
      url = "github:clemak27/homecfg";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, homecfg }:
    {
      homeConfigurations = {
        "clemens@toolbox" = home-manager.lib.homeManagerConfiguration {
          pkgs = self.inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ({ config, pkgs, ... }: {
              nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
            })
            homecfg.nixosModules.homecfg
            homecfg.nixosModules.nvim-plugins
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
