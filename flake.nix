{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = github:Mic92/sops-nix;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, flake-utils }:
    let
      devpkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {

      nixosConfigurations.zenix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          ./hosts/zenix/configuration.nix
        ];
      };

      nixosConfigurations.xps15 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          ./hosts/xps15/configuration.nix
        ];
      };

      nixosConfigurations.e470 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          ./hosts/e470/configuration.nix
        ];
      };

      devShell.x86_64-linux = devpkgs.mkShell {
        nativeBuildInputs = with devpkgs; [
          dconf2nix
          sops
          age
          ssh-to-age
        ];
      };

    };
}
