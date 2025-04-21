#!/bin/bash

set -xueo pipefail

rpm-ostree install --idempotent podman-docker podman-compose
sudo mkdir -p /etc/containers
sudo touch /etc/containers/nodocker
systemctl --user enable podman.socket
