{ pkgs, config, ... }:
{
  # virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.clemens.extraGroups = [ "libvirtd" ];
}
