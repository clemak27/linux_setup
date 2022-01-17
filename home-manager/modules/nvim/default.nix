{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  imports = [
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

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "notes"; value = "nvim ~/Notes/index.md"; }
      ]
    );

    home.packages = with pkgs; [
      nodePackages.eslint
      nodePackages.markdownlint-cli
      rnix-lsp
      shellcheck
    ] ++ lib.optionals stdenv.isLinux [
      sumneko-lua-language-server
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
