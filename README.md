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
- pipewire (since it replaces pulseaudio -> leads to promt `pipewire-pulse and pulseaudio are in conflict. Remove pulseaudio? [y/N]`)
  - `paru -S pipewire pipewire-pulse pipewire-jack pipewire-alsa`
- zsh custom plugins
- installed fpr aurBuilder:
  - spotify-tui
  - nerd-fonts-fira-code
- gitea-tea install ([aur package](https://aur.archlinux.org/packages/gitea-tea) seems outdated?)

```shell
go get code.gitea.io/tea && go install code.gitea.io/tea
tea shellcompletion zsh
mkdir -p ~/.oh-my-zsh/custom/plugins/tea
mv /home/clemens/.config/tea/autocomplete.zsh ~/.oh-my-zsh/custom/plugins/tea
echo "PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source ~/.oh-my-zsh/custom/plugins/tea/autocomplete.zsh" > ~/.oh-my-zsh/custom/plugins/tea/tea.plugin.zsh
```

## 144Hz

- Add MaxFPS=144 to your ~/.config/kwinrc under [Compositing]
- Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
- about:config layout.frame_rate 144
