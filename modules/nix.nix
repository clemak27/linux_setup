{ config, pkgs, ... }:
let
  updateSystem = pkgs.writeShellScriptBin "update-system" ''
    cd $HOME/Projects/linux_setup
    nix flake update
    git add flake.nix flake.lock
    git commit -m "chore(flake): Update $(date -I)"
    sudo nixos-rebuild switch --flake . --impure
    tldr --update
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    cd -
  '';
in
{
  nix.autoOptimiseStore = true;
  nix.package = pkgs.nix_2_4;

  # flake support
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  environment.systemPackages = with pkgs; [
    updateSystem
  ];
}
