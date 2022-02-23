{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = github:Mic92/sops-nix;
  };

  outputs = { self, nixpkgs, home-manager, sops-nix }:
    {
      homeConfigurations = {
        "clemens@toolbox" = home-manager.lib.homeManagerConfiguration {
          configuration = ./home.nix;
          system = "x86_64-linux";
          homeDirectory = "/home/clemens";
          username = "clemens";
          stateVersion = "21.05";
        };
      };
    };
}
