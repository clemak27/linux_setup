{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
  ghRepo = pkgs.fetchFromGitHub {
    owner = "iamcco";
    repo = "markdown-preview.nvim";
    rev = "e5bfe9b89dc9c2fbd24ed0f0596c85fd0568b143";
    sha256 = "0bfkcfjqg2jqm4ss16ks1mfnlnpyg1l4l18g7pagw1dfka14y8fg";
  };

  yarnPkg = pkgs.mkYarnPackage {
    src = ghRepo;
    packageJSON = builtins.fetchurl https://raw.githubusercontent.com/iamcco/markdown-preview.nvim/master/app/package.json;
    yarnLock = builtins.fetchurl https://raw.githubusercontent.com/iamcco/markdown-preview.nvim/master/app/yarn.lock;
  };
  markdown-preview = pkgs.stdenv.mkDerivation {
    name = "markdown-preview-nvim";
    src = ghRepo;
    installPhase = ''
      mkdir -p $out
      cp -R . $out
      cp -R ${yarnPkg}/libexec/markdown-preview-vim/node_modules $out/app
    '';
  };
  markdown-preview-plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "markdown-preview.nvim";
    version = "2021-03-10";
    src = markdown-preview;
  };
in
{
  config = lib.mkIf (cfg.advanced && config.homecfg.dev.node.enable) {
    home.file = {
      ".markdownlintrc".source = ./markdownlintrc;
    };

    programs.neovim.plugins = with pkgs; [
      vimPlugins.vim-markdown
      vimPlugins.tabular
      markdown-preview-plugin
    ];

    homecfg.nvim.pluginSettings = ''
      lua require('vim-markdown-config').load()
    '';

    home.packages = with pkgs; [
      nodePackages.markdownlint-cli
    ];

    xdg.configFile = {
      "nvim/lua/vim-markdown-config.lua".source = ../lua/vim-markdown-config.lua;
    };
  };
}
