<!-- markdownlint-disable -->
# Fedora SilverBlue installation

## Setup

- create live USB (if there is none yet)
- boot from live USB
- install it

```sh
mkdir Projects
cd Projects/
git clone https://github.com/clemak27/linux_setup # (or with ssh if key imported: git@github.com:clemak27/linux_setup.git)
cd linux_setup/
```

- run the install-scripts in the order

### create the godbox

```sh
toolbox
sh <(curl -L https://nixos.org/nix/install) --no-daemon
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
# init home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-env --set-flag priority 0 nix
nix-shell '<home-manager>' -A install
home-manager switch --flake . --impure
nix-channel --remove home-manager
nix-channel --update
```

add to .bashrc:

```sh
alias tb='toolbox'

if [[ $HOSTNAME == "toolbox" ]]; then
  export NIX_PROFILES="/nix/var/nix/profiles/default /var/home/clemens/.nix-profile"
  export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
  export PATH=/var/home/clemens/.nix-profile/bin:/var/home/clemens/.local/bin:/var/home/clemens/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/home/clemens/.cargo/bin:/var/home/clemens/.go/bin:/var/home/clemens/.local/bin:/var/home/clemens/.local/bin/npm/bin
  /var/home/clemens/.nix-profile/bin/zsh
fi
```
