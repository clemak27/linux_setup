#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

rpm-ostree install --idempotent podman-docker podman-compose
sudo mkdir -p /etc/containers
sudo touch /etc/containers/nodocker
systemctl --user enable podman.socket
mkdir -p "$config_dir/containers"
# https://github.com/containers/podman/issues/3234#issuecomment-497541854
# https://github.com/containers/podman/issues/10817#issuecomment-1563103744
# restorecon -RFv /home/clemens/.local/share/containers
