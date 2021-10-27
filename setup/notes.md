---
run form.sh
generate config+hardware config
copy configuration.nix
  rm imports for other files
  update uuid with correct one
--- reboot
login/boot to new system
switch to unstable && add home-manager
as root:
  nix-channel --add https://nixos.org/channels/nixos-unstable nixos
  nix-channel --add https://nixos.org/channels/nixos-21.05 nixos-stable
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nixos-rebuild switch --upgrade
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
done

TODO NOW:
- update README
- use hashed pw in secrets nix
TODO LATER:
- make device configurable
- yeet secrets.nix https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes, or at least 
- go back to packer/vim-plug???
- automatic update + garbarge collection

```txt
lualine repository has been moved to nvim-lualine organization and this repo
has been archived. Please switch to nvim-lualine/lualine.nvim for updates.

To switch you'll have to change a but of config in your plugin manager.
Some current plugin manager examples.
```
