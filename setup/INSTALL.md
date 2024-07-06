# NixOS installation

## Setup

### Preparation

- create live USB (if there is none yet)
- create new branch for host
- prepare config in hosts directory

### NixOS install

- Disable Secure Boot
- Boot from live USB
- Open a terminal and checkout the repo:
  `git clone https://github.com/clemak27/linux_setup`
- `cd linux_setup/setup`
- Update `setup_disc.sh` with the device where nix should be installed (check
  with `lsblk`)
- Run `sudo ./setup_disc.sh`
- Update the config of the host in the repo with the generated
  `/mnt/etc/nixos/hardware-configuration.nix` and the `deviceUUID` of the root
  partition in `configuration.nix`.
- Make sure the `nixosConfiguration` does not include `secureboot.nix`
- Install NixOS with
  `sudo nixos-install --root /mnt --flake .#<hostname> --impure`
- Reboot

### Configuring the system

- Login as normal user
- Checkout the repo: (if there is a backed up ssh key, use it to clone with ssh)

  ```sh
  mkdir -p ~/Projects
  cd ~/Projects
  git clone https://github.com/clemak27/linux_setup.git
  git submodule update --remote --rebase
  ```

- Update the config of the host in the repo again with the generated
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

### TPM

Based on
[this guide](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

- After installing, TPM should be set up correctly
- Check if Secure Boot is disabled and TPM enabled: `bootctl status`
- Create keys with `sudo sbctl create-keys`
- Add `secureboot.nix` to the list of modules for the `nixosConfiguration`
- Rebuild the system and check the status: `sudo sbctl verify`
- Reboot into BIOS and enable Secure Boot, it should be in Setup Mode (delete
  the Platform key for this if there is no option, or delete everything if it
  doesn't work).
- Enrol the keys in Secure Boot: `sudo sbctl enroll-keys --microsoft`
- After another reboot, Secure Boot should be enabled, check with
  `bootctl status`.
- Enable automatic unlocking with
  `sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/<encrypted disk>`
