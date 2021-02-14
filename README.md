# my ArchLinux setup

I use arch btw. [![pipeline status](https://gitlab.com/clemak27/linux_setup/badges/master/pipeline.svg)](https://gitlab.com/clemak27/linux_setup/commits/master)

## Open things to automate

- `systemctl --user enable ssh-agent.service`
- `systemctl --user enable openrgb.service`
- `systemctl --user enable syncthing.service`
- `systemctl --user start syncthing.service`
- `systemctl --user enable spotifyd.service`
- `systemctl --user start spotifyd.service`
- `systemctl --user enable redshift.service`
- event calendar gets installed but is missing?
- need to install pipewire manually (since it replaces pulseaudio)
  - `paru -S pipewire pipewire-pulse pipewire-jack pipewire-alsa
