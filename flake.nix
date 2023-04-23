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

    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, homecfg, sops-nix, flake-utils-plus }:
    let
      pkgs = self.pkgs.x86_64-linux.nixpkgs;
      updateSystem = pkgs.writeShellScriptBin "update-system" ''
        if [ "$(cat flake.lock | sha256sum)" = "$(curl https://raw.githubusercontent.com/clemak27/linux_setup/master/flake.lock | sha256sum)" ]; then
          echo "system up to date"
        else
          locksha=$(cat ./dotfiles/lazy-lock.json | sha256sum)
          git pull --rebase
          sudo nixos-rebuild switch --impure --flake .
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
    flake-utils-plus.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channels.nixpkgs = {
        config = { allowUnfree = true; };
        overlaysBuilder = channels: [
          (final: prev: { stable = self.inputs.nixpkgs-stable.legacyPackages.x86_64-linux; })
        ];
      };

      hostDefaults = {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops
          ./modules/general.nix
          ./modules/gnome
          ./modules/pipewire.nix
          ./modules/virt-manager.nix
          ./modules/container.nix
          ./modules/ssh.nix
          ./modules/flatpak.nix
        ];
        channelName = "nixpkgs";
      };

      hosts = {
        argentum = {
          modules = [
            ./hosts/argentum/configuration.nix
          ];
        };

        silfur = {
          modules = [
            ./hosts/silfur/configuration.nix
          ];
        };

        virtual = {
          modules = [
            ./hosts/virtual/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        clemens = home-manager.lib.homeManagerConfiguration {
          pkgs = self.pkgs.x86_64-linux.nixpkgs;
          modules = [
            ({ config, pkgs, ... }: {
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

      outputsBuilder = channels: {
        devShell = channels.nixpkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            sops
            dconf2nix
            updateSystem
          ];
        };
      };
    };
}
