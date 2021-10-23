# nix_setup

My development environment, setup with the nix package manager.
Inspired several blog posts and git repos around the internet.

## Setup

### Install nix

#### General

Refer to [the download page](https://nixos.org/download.html)

Add unstable channel:

```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

check if the setup works by running `nix-env -i hello` and `hello` / `which hello`.

### Install home-manager

Refer to [the download page](https://nix-community.github.io/home-manager/index.html#ch-installation).

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### Installing this setup

1. symlink the config files in the repo to the config dir of home-manager:

```sh
ln -sf <absolute path to this repo>/nixpkgs <absolute path to home>/.config/nixpkgs
```
<!-- markdownlint-disable-next-line ol-prefix -->
2. create a `home.nix`, that defines which parts of the setup to use
(which could be different, depending on the machine's use)

The setup can be configured by providing a homecfg object,
per default all configurations are not enabled.

A basic `home.nix` looks like this:

```nix
{ config, pkgs, lib,... }:

{
  imports = [
    ./homecfg.nix
  ];

  homecfg = {
    git = {
      enable = true;
      user = "mikeal";
      email = "mikeal@hemvist.org";
      tea = true;
      gh = false;
    };
  };
}
```

After that, you can run `home-manager switch` to enable the setup.

## Notes

Properly rewriting the dotfiles in nix is planned in the future.

### nix search path for root does not exist

You can fix

``` sh
warning: Nix search path entry '/nix/var/nix/profiles/per-user/root/channels/nixpkgs' does not exist, ignoring
```

with

```sh
sudo -i nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
sudo -i nix-channel --update nixpkgs
```

[Source](https://github.com/NixOS/nix/issues/2982)
