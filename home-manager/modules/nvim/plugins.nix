{ config, lib, pkgs, ... }:
let
  vim-textobj-parameter = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-textobj-parameter-git";
    version = "2017-05-16";
    src = builtins.fetchGit {
      url = "https://github.com/sgur/vim-textobj-parameter.git";
      ref = "HEAD";
      rev = "201144f19a1a7081033b3cf2b088916dd0bcb98c";
    };
  };
  onedark-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "onedark-nvim-git";
    version = "2021-11-05";
    src = builtins.fetchGit {
      url = "https://github.com/ful1e5/onedark.nvim.git";
      ref = "HEAD";
      rev = "3833202fc5b579120a34d37842334cda23ffdfac";
    };
  };
in
{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
    ];

  };

}
