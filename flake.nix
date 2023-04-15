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
      updateSystem = devpkgs.writeShellScriptBin "update-system" ''
        if [ "$(cat flake.lock | sha256sum)" = "$(curl https://raw.githubusercontent.com/clemak27/linux_setup/master/flake.lock | sha256sum)" ]; then
          echo "system up to date"
        else
          local locksha=$(cat ./dotfiles/lazy-lock.json | sha256sum)
          git pull --rebase
          sudo nixos-rebuild boot --impure --flake .
          home-manager switch --impure --flake . 
          flatpak update -y
          if [ "$(cat ./dotfiles/lazy-lock.json | sha256sum)" = "$locksha" ]; then
            nvim tmpfile +"lua require('lazy').sync({wait=true}); vim.cmd('qa!')"
            git add ./dotfiles/lazy-lock.json
            git commit -m "chore: update lazy-lock"
            git push
          else
            nvim tmpfile +"lua require('lazy').restore({wait=true}); vim.cmd('qa!')"
          fi
        fi
      '';
    in
    {
      nixosConfigurations = {
        argentum = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/argentum/configuration.nix
            ./modules/general.nix
            ./modules/gnome
            ./modules/pipewire.nix
            ./modules/virt-manager.nix
            ./modules/container.nix
            ./modules/ssh.nix
            ./modules/flatpak.nix
          ];
        };

        silfur = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/silfur/configuration.nix
            ./modules/general.nix
            ./modules/gnome
            ./modules/pipewire.nix
            ./modules/virt-manager.nix
            ./modules/container.nix
            ./modules/ssh.nix
            ./modules/flatpak.nix
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
          updateSystem
        ];
      };
    };
}
