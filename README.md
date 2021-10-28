# my NixOS setup

rip arch linux 15.06.2019 - 28.10.2021

## Setup (WIP)

### Existing machine

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
  ```
  - as normal user: (if there is a backed up ssh key, gcl with ssh)
  ```sh
  nix-shell '<home-manager>' -A install
  mkdir -p ~/Projects
  cd ~/Projects
  git clone https://github.com/clemak27/linux_setup.git
  ```
- copy hardware-configuration.nix to git-repo
- copy uuid from /etc/nixos/configuration.nix to configuration.nix of git-repo
- symlink configs:
```sh
sudo ln -sf /home/clemens/Projects/linux_setup/hosts/zenix/configuration.nix /etc/nixos/configuration.nix
rm -rf ~/.config/nixpkgs
ln -sf /home/clemens/Projects/linux_setup/home-manager /home/clemens/.config/nixpkgs
```
- create a secrets.nix in hosts/<hostname> directory according to template in setup dir (mkpasswd -m sha-512)
- activate the new system:
```sh
sudo nixos-rebuild boot --upgrade
sudo nix-env -f channel:nixos-21.05 -iA sublime-music
home-manager switch
```
- reboot
- manually install plasma wdigets/kwin scripts:
  - bismuth (`wget -q -O - https://git.io/J2gLk | sh`)
  - dynamic workspaces (GUI)
  - event calendar (GUI)
- restore plasma shortcuts from file
- restore latte layout from file
- change color scheme to skyBlue
- run `home-manager/configs/NixOS/plasma/config.sh` to setup plasma

### TODO LATER (create GH issues?)
- Update website
  - screenshots
  - history section?
  - add linux-DE rant? 👀
- NixOS - part 2:
  - new wallpaper
  - automate as much of setup as possible
    - plasma things can possibly installed with tgz
  - move parts of zenix config to general folder
  - move home.nix around?
  - yeet secrets.nix https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes
  - automatic updates + garbarge collection
- multi-monitor support
  - add new wallpapers
  - add plasma extensions for better support
- add tests for config (gh-action?)
- custom NixOS usb (possible?)
- install NixOS on xps15
- go back to packer/vim-plug or update colorscheme/lualine:
```txt
lualine repository has been moved to nvim-lualine organization and this repo
has been archived. Please switch to nvim-lualine/lualine.nvim for updates.
```
- support printer @zenix (derv like this i guess: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/misc/cups/drivers/mfcl2700dncupswrapper/default.nix#L38, or make generic driver work lol)
  
## What's in this repo?

the result of ~1 week of vacation lol

## Why?

I don't know and hate myself. ¯\\\_(ツ)_/¯
