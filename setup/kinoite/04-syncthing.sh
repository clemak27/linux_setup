#!/bin/bash

set -xueo pipefail

mkdir -p "$HOME/.local/state/syncthing"
mkdir -p "$HOME/.config/containers/systemd"

cat << EOF > "$HOME/.config/containers/systemd/syncthing.container"
[Container]
Image=docker.io/syncthing/syncthing
AutoUpdate=registry
Network=host
Volume=%h:%h
SecurityLabelDisable=true
Environment=STHOMEDIR=%h/.local/state/syncthing
Environment=HOME=%h
UserNS=keep-id
User=1000:1000

[Service]
Restart=always
TimeoutStartSec=900

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger
