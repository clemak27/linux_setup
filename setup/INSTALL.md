# NixOS installation

## Setup

### Preparation

- create live USB (if there is none yet)
- create new branch for host
- prepare config in `hosts` directory
  - Make sure all options requiring files to exist in the system are not enabled
    (e.g. git signing in the `homecfg`, Wireguard, ...)
  - Make sure the `nixosConfiguration` does not include `secureboot.nix`

### NixOS install

- Disable Secure Boot
- Boot from live USB
- Open a terminal and checkout the repo:
  `git clone https://github.com/clemak27/linux_setup --branch feat/maxwell-9700x`
- `cd linux_setup`
- Update `hosts/<hostname>/disko.nix` with the device where nix should be
  installed (check with `lsblk`)
- Create a file containing the passphrase:
  `echo -n "superSecret" > /tmp/secret.key`
- Run
  `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount hosts/<hostname>/disko.nix`
- Set `users.users.<name>.initialPassword`. Otherwise, you would need to log in
  as root after rebooting to set it up.
- Update the hardware-configuration:
  `nixos-generate-config --no-filesystems --root /mnt > hosts/<hostname>/hardware-configuration.nix`
- Install NixOS with
  `sudo nixos-install --root /mnt --flake .#<hostname> --impure`
- Reboot

### Configuring the system

- Login as normal user.
- Checkout the repo with git.
- Update the config of the host in the repo again with the generated
  `/mnt/etc/nixos/hardware-configuration.nix`.
- Apply additional changes as needed.

## Notes

### WireGuard

The files where WireGuard reads the keys from needs to be created manually.

1. The files should have no line ending. If you insert the keys with vim, use
   `:set nofixeol noeol`, to prevent adding a newline when saving.
2. The file should be updated to have `400` (read only) permission after
   creating them.

The reason I'm not using `sops` for this is that is led to issues in the past.

### Automatic TPM/LUKS unlocking

Based on
[this guide](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

- After installing, TPM should be set up correctly
- Check if Secure Boot is disabled and TPM enabled: `bootctl status`
- Create keys with `sudo sbctl create-keys`
- Add lanzaboote to the config for the host:

  ```nix
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl"; # was /etc/secureboot in older versions
  };
  ```

- Rebuild the system and check the status: `sudo sbctl verify`
- Reboot into BIOS and enable Secure Boot, it should be in Setup Mode (delete
  the Platform key for this if there is no option, or delete everything if it
  doesn't work).
- Enrol the keys in Secure Boot: `sudo sbctl enroll-keys --microsoft`
- After another reboot, Secure Boot should be enabled, check with
  `bootctl status`.
- Enable automatic unlocking with
  `sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/<encrypted disk>`
