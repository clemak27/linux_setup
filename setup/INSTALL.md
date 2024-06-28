# NixOS installation

## Setup

### Preparation

- create live USB (if there is none yet)
- create new branch for host
- prepare config in hosts directory

### NixOS install

- boot from live USB
- Open a terminal and checkout the repo:
  `git clone https://github.com/clemak27/linux_setup`
- `cd linux_setup/setup`
- update `setup_disc.sh` with the device where nix should be installed (check
  with `lsblk`)
- run `sudo ./setup_disc.sh`
- update the config of the host in the repo with the generated
  `/mnt/etc/nixos/hardware-configuration.nix` and the `deviceUUID` of the root
  partition in `configuration.nix`.
- Install NixOS with
  `sudo nixos-install --root /mnt --flake .#<hostname> --impure`
- reboot

### Configuring the system

- login as normal user
- checkout the repo: (if there is a backed up ssh key, use it to clone with ssh)

  ```sh
  mkdir -p ~/Projects
  cd ~/Projects
  git clone https://github.com/clemak27/linux_setup.git
  git submodule update --remote --rebase
  ```

- update the config of the host in the repo again with the generated
  `/mnt/etc/nixos/hardware-configuration.nix` and the `deviceUUID` of the root
  partition in `configuration.nix`.

## Notes

### To convert an ssh ed25519 key to an age key

```sh
mkdir -p ~/.config/sops/age
cp $HOME/.ssh/id_ed25519 /tmp/id_ed25519
ssh-keygen -p -N "" -f /tmp/id_ed25519
ssh-to-age -private-key -i /tmp/id_ed25519 > ~/.config/sops/age/keys.txt
rm /tmp/id_ed25519
age-keygen -y ~/.config/sops/age/keys.txt
```

### btrfs config

`nixos-generate-config --show-hardware-config` doesn't detect mount options
automatically, so to enable compression, you must specify it and other mount
options in a persistent configuration:

```nix
fileSystems = {
"/".options = [ "compress=zstd" ];
"/home".options = [ "compress=zstd" ];
"/nix".options = [ "compress=zstd" "noatime" ];
"/swap".options = [ "noatime" ];
};
```

For the swapfile, add `swapDevices = [ { device = "/swap/swapfile"; } ];`

[Source](https://nixos.wiki/wiki/Btrfs)

### WireGuard

The files where WireGuard reads the keys from needs to be created manually.

1. The files should have no line ending. If you insert the keys with vim, use
   `:set nofixeol noeol`, to prevent adding a newline when saving.
2. The file should be updated to have `400` (read only) permission after
   creating them.
