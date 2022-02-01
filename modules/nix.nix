{ config, pkgs, ... }:
let
  updateSystem = pkgs.writeShellScriptBin "update-system" ''
    cd $HOME/Projects/linux_setup
    nix flake update --commit-lock-file --commit-lockfile-summary "chore(flake): Update $(date -I)"
    sudo nixos-rebuild switch --flake . --impure
    tldr --update
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    cd -
  '';
in
{
  nix = {
    package = pkgs.nix_2_6;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    updateSystem
  ];
}
