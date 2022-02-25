# Fedora SilverBlue installation

## Setup

### Inital

- create live USB (if there is none yet)
- boot from live USB
- install it

### First boot

- checkout git repo:

```sh
mkdir Projects
cd Projects/
git clone https://github.com/clemak27/linux_setup # (or with ssh if key imported: git@github.com:clemak27/linux_setup.git)
cd linux_setup/setup
```

- Run the first install-script and then reboot
- After the reboot, run the second

### create toolboxes

- this is only semi-automated for now:
- create the default toolbox:
  - `toolbox create`
  - `toolbox enter` and run `./init_nix_toolbox.sh`
- install subĺime-music:
  - `toolbox create sublime-music`
  - `toolbox run -c sublime-music ./init_sublime_music_toolbox.sh`

## Notes

- enable wg config after copying: `sudo systemctl enable --now wg-quick@home`
- sublime-music container is weird
- clipboard is weird
- add evolution
- move proton-ge install somehere else
