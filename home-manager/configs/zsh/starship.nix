{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.zsh;
in
{
  config = lib.mkIf (cfg.enable) {
    programs.starship.enable = true;
    programs.starship.enableZshIntegration = true;

    programs.starship.settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
      kubernetes = {
        disabled = true;
        format = "[$symbol$context( \($namespace\))]($style) ";
      };
      directory = {
        format = "[ $path]($style)[$read_only]($read_only_style) ";
        style = "bold blue";
        truncation_length = 99;
        truncate_to_repo = false;
      };
      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        style = "bold green";
      };
      git_status = {
        style = "bold yellow";
      };
      nix_shell = {
        disabled = false;
        format = "[$symbol]($style) ";
        symbol = " ";
      };
      aws = {
        disabled = true;
      };
      battery = {
        disabled = true;
      };
      cmd_duration = {
        disabled = true;
      };
      conda = {
        disabled = true;
      };
      dotnet = {
        disabled = true;
      };
      docker_context = {
        disabled = true;
      };
      elixir = {
        disabled = true;
      };
      elm = {
        disabled = true;
      };
      gcloud = {
        disabled = true;
      };
      golang = {
        disabled = true;
      };
      java = {
        disabled = true;
      };
      julia = {
        disabled = true;
      };
      memory_usage = {
        disabled = true;
      };
      nim = {
        disabled = true;
      };
      nodejs = {
        disabled = true;
      };
      package = {
        disabled = true;
      };
      php = {
        disabled = true;
      };
      python = {
        disabled = true;
      };
      ruby = {
        disabled = true;
      };
      rust = {
        disabled = true;
      };
    };

  };
}

