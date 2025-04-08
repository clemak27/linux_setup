#!/bin/bash

set -eo pipefail

module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
config_dir="$HOME/.config"

rpm-ostree install --idempotent podman-docker podman-compose
sudo mkdir -p /etc/containers
sudo touch /etc/containers/nodocker
systemctl --user enable podman.socket
mkdir -p "$config_dir/containers"
ln -sf "$module_dir/containers.conf" "$config_dir/containers/containers.conf"
ln -sf "$module_dir/registries.conf" "$config_dir/containers/registries.conf"
ln -sf "$module_dir/testcontainers.properties" "$HOME/.testcontainers.properties"
