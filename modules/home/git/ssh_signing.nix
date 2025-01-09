{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homecfg.git;
in
{
  options.homecfg.git.ssh_key = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "The ssh key (public part) that is used to sign git commits.";
    example = "ssh-ed25519 ABCD hostname";
  };

  config = lib.mkIf (cfg.enable && cfg.ssh_key != "") {
    programs.git = {
      extraConfig = {
        commit.gpgsign = "true";
        gpg.format = "ssh";
        user.signingkey = "${cfg.ssh_key}";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };

    home.file.".ssh/allowed_signers".text = "${cfg.email} ${cfg.ssh_key}";
  };
}
