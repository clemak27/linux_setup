# my NixOS setup

## Setup (WIP)

- if applicable: backup content of old OS (ssh-keys, pwd.key file, screenshots, ...)
- if there is none yet: create NixOS live usb
  - https://nixos.org/download.html#nixos-iso
- Boot from live USB
- update setup/form.sh with the device where nix should be installed (check with `lsblk`)
- run form.sh
- generate initial config: `nixos-generate-config --root /mnt`
  - create user with simple password
  ```nix
  users.users.clemens = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    password = "1234";
  };
  ```
  - make encryption work by adding  
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
  - reboot into new system
  - login as normal user
  - switch to unstable && add home-manager:
    - as root:
    ```sh
    nix-channel --add https://nixos.org/channels/nixos-unstable nixos
    nix-channel --add https://nixos.org/channels/nixos-21.05 nixos-stable
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nixos-rebuild switch --upgrade
    ```
    - as normal user:
    ```sh
    nix-shell '<home-manager>' -A install
    mkdir -p ~/Projects
    cd ~/Projects
    git clone https://github.com/clemak27/linux_setup.git
    ```
    - copy hardware-configuration.nix to git-repo
    - copy uuid from /etc/nixos/configuration.nix to configuration.nix of git-repo
---------------------------------------------------------------------------------------------

as normal user:
  nix-shell '<home-manager>' -A install
  mkdir -p ~/Projects
  cd ~/Projects
  git clone https://github.com/clemak27/linux_setup.git
  copy hardware-configuration.nix to repo
  copy uuid from configuration.nix to configuration.nix of repo
  symlink configs
    sudo ln -sf /home/clemens/Projects/linux_setup/hosts/zenix/configuration.nix /etc/nixos/configuration.nix
    rm ~/.config/nixpkgs
    ln -sf /home/clemens/Projects/linux_setup/home-manager /home/clemens/.config/nixpkgs
  nixos-rebuild boot
  home-manager switch
--- reboot
manually install plasma wdigets/kwin scripts:
- bismuth (wget -q -O - https://git.io/J2gLk | sh)
- dynamic workspaces (GUI)
- event calendar (GUI)
restore plasma shortcuts from file
restore latte layout from file
change color scheme to skyBlue
run kwinrc.sh

TODO NOW:
- update README
- use hashed pw in secrets nix
- update update_nix helper
TODO LATER:
- make device configurable
- yeet secrets.nix https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes
- go back to packer/vim-plug???
- automatic update + garbarge collection
- support printer (derv like this i guess: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/misc/cups/drivers/mfcl2700dncupswrapper/default.nix#L38)

```txt
lualine repository has been moved to nvim-lualine organization and this repo
has been archived. Please switch to nvim-lualine/lualine.nvim for updates.

To switch you'll have to change a but of config in your plugin manager.
Some current plugin manager examples.
```

mkpasswd -m sha-512


## What's in this repo?


## Why?

I don't know. ¯\\\_(ツ)_/¯
