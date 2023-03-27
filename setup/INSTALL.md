# NixOS installation

## Setup

### Preparation

- create live USB (if there is none yet)
- create new branch for host
- prepare config in hosts directory

### NixOS install

- boot from live USB
- checkout repo: `git clone https://github.com/clemak27/linux_setup`
- `cd linux_setup/setup`
- update `setup_nixos.sh` with the device where nix should be installed
  (check with `lsblk`)
- run `sudo ./setup_nixos.sh`
- install it with `sudo nixos-install`
- reboot into new system

### Configuring the system

- login as normal user
- checkout repo: (if there is a backed up ssh key, use it to clone with ssh)

  ```sh
  mkdir -p ~/Projects
  cd ~/Projects
  git clone https://github.com/clemak27/linux_setup.git
  git submodule update --remote --rebase
  ```

- run the next script:
- `cd linux_setup/setup`
- run `./setup_system.sh`
- `cd ..`
- edit the config:
  - copy the device uuid from the init config to the actual one
  - set the swapfile and mounting options according to [btrfs config](#btrfs config)
- run

```sh
sudo nixos-rebuild boot --flake .
```

- reboot

### Home-manager

nix run home-manager/master -- init --switch
rm -rf /home/clemens/.config/home-manager
home-manager switch --flake .

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
automatically, so to enable compression, you must specify it and other
mount options in a persistent configuration:

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
