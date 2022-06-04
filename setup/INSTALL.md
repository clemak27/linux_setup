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

- Run the first install-script `0_ostree.sh`
- Unfortunately, my laptop has an n0video GPU, so it also needs `0a_nvidia.sh`
- reboot
- run the `1_applications.sh` script

### create toolboxes

- create the default toolbox:
  - `toolbox create`
  - `toolbox enter` and run `./init_nix_toolbox.sh`

## Notes

- enable wg config after copying: `sudo systemctl enable --now wg-quick@home`
