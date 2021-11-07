{ config, pkgs, ... }:
{
  swapDevices = [{
    device = "/swapfile";
    size = (1024 * 16) + (1024 * 2);
  }];
}
