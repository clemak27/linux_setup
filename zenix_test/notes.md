run form.sh
copy configuration.nix
switch to unstable && add home-manager
as root:
  nix-channel --add https://nixos.org/channels/nixos-unstable nixos
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nixos-rebuild switch --upgrade

TODO:
- update README
- make device configurable
