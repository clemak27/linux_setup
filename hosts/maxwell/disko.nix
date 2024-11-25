{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                extraArgs = [ "-L" "boot" ];
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "fmask=0022" "dmask=0022" ];
              };
            };
            primary = {
              label = "primary";
              size = "100%";
              content = {
                type = "luks";
                name = "luksroot";
                passwordFile = "/tmp/secret.key";
                settings = {
                  allowDiscards = true;
                  preLVM = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "lvm";
                };

              };
            };
          };
        };
      };
    };
    lvm_vg = {
      lvm = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-L" "nixos" ];
              subvolumes = {
                "root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" ];
                };
                "home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "swap" = {
                  mountpoint = "/swap";
                  mountOptions = [ "noatime" ];
                  swap.swapfile.size = "8G";
                };
              };
            };
          };
        };
      };
    };
  };
}
