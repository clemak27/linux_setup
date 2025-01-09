{
  config,
  lib,
  pkgs,
  ...
}:
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
      extraPackages = with pkgs; [
        cargo
        deno
        gcc
        nodejs_22
        python311
        yarn

        # html/css/json/eslint
        nodePackages.vscode-langservers-extracted

        # markdown
        nodePackages.markdownlint-cli
        ltex-ls

        # container
        hadolint

        # yaml
        nodePackages.yaml-language-server
        yamlfmt
        yamllint

        # shell
        nodePackages.bash-language-server
        shellcheck
        shfmt

        # nix
        nixd
        nixfmt-rfc-style

        # lua
        lua-language-server
        stylua

        # go
        delve
        gofumpt
        golangci-lint
        golangci-lint-langserver
        (gopls.override { buildGoModule = pkgs.buildGo123Module; })
        gotools

        # js
        biome
        nodePackages.prettier
        nodePackages.typescript-language-server
        vscode-js-debug
        vue-language-server

        # rust
        rust-analyzer

        # python
        python312Packages.black
        python312Packages.jedi-language-server

        # kotlin-language-server
        kotlin-language-server
      ];
    };

    home.file = {
      ".markdownlintrc".text = (
        builtins.toJSON {
          default = true;
          MD013 = {
            code_blocks = false;
          };
        }
      );
    };

    programs.zsh = {
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };

    xdg.configFile = {
      "nvim/init.lua".source = ./init.lua;
      "nvim/lua".source = ./lua;

      "yamlfmt/.yamlfmt".text = ''
        formatter:
          type: basic
          include_document_start: true
          pad_line_comments: 2
          retain_line_breaks_single: true
      '';
    };
  };
}
