# My Linux setup

This repo contains my dotfiles and setup for my Linux devices:

- `maxwell`: Desktop-PC
  - Runs Fedora Kinoite
  - Current Specs:
    - CPU: AMD Ryzen 7 9700X
    - GPU: AMD Radeon RX 6700 XT
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
as inspiration.

## Package Management

My current setup works like this:

| What              | Where        |
| ----------------- | ------------ |
| OS specific stuff | `rpm-ostree` |
| GUI               | `flatpak`    |
| TUI               | `brew`       |
| nvim-plugins      | `lazy.nvim`  |
| LSP/DAP           | `mason.nvim` |
| dotfiles          | `chezmoi`    |
| project-specific  | `mise`       |
