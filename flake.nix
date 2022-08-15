{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = github:Mic92/sops-nix;
    homecfg = {
      url = "github:clemak27/homecfg";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, homecfg }:
    {
      homeConfigurations = {
        "clemens@toolbox" = home-manager.lib.homeManagerConfiguration {
          pkgs = self.inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            "${self.inputs.homecfg}/default.nix"
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
