<!-- markdownlint-disable -->
# my NixOS setup

readme is WIP, plz don't judge

## Setup

### Preparation

- create live USB (if there is none yet)
- create new branch for host
- prepare config in hosts directory

### NixOS install

- boot from live USB
- checkout repo: `git clone https://github.com/clemak27/linux_setup`
- `cd linux_setup/setup`
- update `setup_nixos.sh` with the device where nix should be installed (check with `lsblk`)
- run `sudo ./setup_nixos.sh`
- update the initial config:
  - create user
  ```nix
  users.users.clemens = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
  ```
  - make encryption work by adding (replace initial bootload config):
  ```nix
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/af78f4e2-205b-4ca7-b4f7-923b797dfd41";
    preLVM = true;
    allowDiscards = true;
  };
  ```
    - replace the uuid with the uuid of the encrypted device
      - use `lsblk --fs`, example: `└─sda2         crypto_LUKS 2                af78f4e2-205b-4ca7-b4f7-923b797dfd41`
      - lsblk --fs | grep "crypto_LUKS" | awk '{print $4}'
  - add essential programs:
  ```nix
  environment.systemPackages = with pkgs; [
    zsh
    vim
    wget
    curl
    w3m
    git
    parted
  ];
  ```
- install it with `sudo nixos-install`
- reboot into new system

### Configuring the system

- login as normal user
- checkout repo: (if there is a backed up ssh key, gcl with ssh)
  ```sh
  mkdir -p ~/Projects
  cd ~/Projects
  git clone https://github.com/clemak27/linux_setup.git
  ```
- run the next script:
- `cd linux_setup/setup`
- run `./setup_system.sh`
- edit configuration.nix as wanted and then run:
```sh
sudo nixos-rebuild boot --upgrade
```

### Finishing touches

- reboot
- manually install kwin scripts:
  - bismuth (`wget -q -O - https://git.io/J2gLk | sh`)
  - dynamic workspaces (GUI)
- restore plasma shortcuts from file
- restore latte layout from file
- change color scheme to skyBlue
- run `home-manager/configs/NixOS/plasma/config.sh` to setup plasma
 
## What's in this repo?

the result of ~1 week of vacation 

## Why?

I don't know. ¯\\\_(ツ)_/¯
