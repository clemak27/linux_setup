{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  users.users.clemens = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCyRaO8psuZI2i/+inKS5jn765Uypds8ORj/nVkgSE3 zenix"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3PSHWVz5/LwHEEfo+7y2o5KH7dlLyfySWnyyi7LLxe xps15"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsk9Bh5+4ZsEDFGb7mXDiClvsLwM+jMNr+SPf+auyu7 op6_termux"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA35xMqpMFnqqkPUyDR5KMNQsDMkEKQLIvyvMk0HzVux e470"
    ];
  };
}
