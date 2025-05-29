# My Linux setup

This repo contains my dotfiles and setup for my Linux devices:

- `maxwell`: Desktop-PC
  - Runs Fedora Kinoite
  - Current Specs:
    - CPU: AMD Ryzen 7 9700X
    - GPU: AMD ATI Sapphire Radeon RX 6700
    - Board: MSI MAG B650 TOMAHAWK WIFI
    - Memory: 32 GB
    - Screens: 3440x1440 + 1920x1080
- `newton`: Dell XPS15 (7590)
  - Runs Fedora Kinoite
- `fermi`: Steam Deck
  - Runs bazzite
- `planck`: Pixel 8 Pro
  - Runs GrapheneOS + termux

This is for my own usage and preferences, but you are of course free to use it
as inspiration. I use chezmoi for managing my dotfiles. I could probably build a
custom image with all the additional setup I do, but I'm mostly satisfied how it
works for now.

## Package Managers

My setup works like this:

- OS specific stuff -> `rpm-ostree`
- GUI applications -> `flatpak`
- everything terminal/cli related is running in a distrobox:
  - `quay.io/toolbx/arch-toolbox:latest` as base
  - `pacman`/`paru` for the basic stuff
  - programming languages and associated tools are managed with
    `nix`/`home-manager` (although not in a reproducible way lol)
  - nvim-plugins with `lazy.nvim`
  - LSP + DAP with `mason.nvim` (which might change in the future)
  - for project-specific dependencies, I use `nix` flakes
