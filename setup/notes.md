run form.sh
generate config+hardware config
copy configuration.nix
switch to unstable && add home-manager
as root:
  nix-channel --add https://nixos.org/channels/nixos-unstable nixos
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nixos-rebuild switch --upgrade
cp hardware-configuration nix to this repo

manually install bismuth
wget -q -O - https://git.io/J2gLk | sh

sudo cryptsetup open /dev/nvme0n1p3 arch

sudo ln -sf /home/clemens/Projects/linux_setup/hosts/zenix/configuration.nix /etc/nixos/configuration.nix
rm ~/.config/nixpkgs
ln -sf /home/clemens/Projects/linux_setup/home-manager /home/clemens/.config/nixpkgs

TODO:
- update README
- make device configurable
- fix vim-markdown issue (chmod?)
- add stable channel just in case
- setup sddm theme
- back to i3???
- yeet secrets.nix https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes
