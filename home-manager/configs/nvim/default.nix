{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  imports = [
    ./nvim-plugin-update.nix
    ./jdtls.nix
  ];

  options.homecfg.nvim.enable = lib.mkEnableOption "Manage neovim with homecfg";

  config = lib.mkIf (cfg.enable) {

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = builtins.readFile (./. + "/init.vim");
    };

    home.packages = with pkgs; [
      nodePackages.eslint
      nodePackages.markdownlint-cli
      rnix-lsp
      sumneko-lua-language-server
      shellcheck
    ];

    home.file = {
      ".markdownlintrc".source = ./markdownlintrc;
      ".vsnip".source = ./vsnip;
    };
    xdg.configFile = {
      "nvim/lua".source = ./lua;
    };

  };

}
