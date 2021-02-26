# my ArchLinux setup

I use arch btw. [![pipeline status](https://gitlab.com/clemak27/linux_setup/badges/master/pipeline.svg)](https://gitlab.com/clemak27/linux_setup/commits/master)

## Open things to automate

- systemd services
  - `systemctl --user enable ssh-agent.service`
  - `systemctl --user enable syncthing.service`
  - `systemctl --user start syncthing.service`
  - `systemctl --user enable spotifyd.service`
  - `systemctl --user start spotifyd.service`
  - `systemctl --user enable redshift.service`
- plasma-addons
  - `paru -S plasma5-applets-eventcalendar`
  - `paru -S plasma5-applets-virtual-desktop-bar-git`
- pipewire (since it replaces pulseaudio -> leads to promt `pipewire-pulse and pulseaudio are in conflict. Remove pulseaudio? [y/N]`)
  - `paru -S pipewire pipewire-pulse pipewire-jack pipewire-alsa`
- zsh custom plugins
