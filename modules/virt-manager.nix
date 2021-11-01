{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
  ];
  users.users.clemens.extraGroups = [ "libvirtd" ];
}

# https://nixos.wiki/wiki/Virt-manager ->
# Could not detect a default hypervisor. Make sure the appropriate virtualization packages containing kvm, qemu, libvirt, etc. are installed and that libvirtd is running.
# 
# To resolve
# 
# File in the menu bar -> Add connection
# 
# HyperVisor = QEMU/KVM
# Autoconnect = checkmark
# 
# Connect
