#!/bin/bash

set -xueo pipefail

mkdir -p "$HOME/.local/state/syncthing"

systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger
