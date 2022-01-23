{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = github:Mic92/sops-nix;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {

        nixosConfigurations.zenix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager

            ({ pkgs, ... }: {
              nix.extraOptions = "experimental-features = nix-command flakes";
              nix.package = pkgs.nixFlakes;
              nix.registry.nixpkgs.flake = nixpkgs;

              home-manager.useGlobalPkgs = true;
            })

            ./hosts/zenix/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };

        nixosConfigurations.xps15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager

            ({ pkgs, ... }: {
              nix.extraOptions = "experimental-features = nix-command flakes";
              nix.package = pkgs.nixFlakes;
              nix.registry.nixpkgs.flake = nixpkgs;

              home-manager.useGlobalPkgs = true;
            })

            ./hosts/xps15/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };

        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            dconf2nix
            sops
            age
            ssh-to-age
          ];
          buildInputs = [ ];
        };

      });
}
